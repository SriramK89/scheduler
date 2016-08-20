class ResourceUsage < ApplicationRecord
  include ActiveModel::Validations
  # VALIDATIONS
  validates_with DateTimeValidator
  validates :resource, presence: { message: 'was not found to be allocated.' }

  # ASSOCIATIONS
  belongs_to :resource
  belongs_to :user

  # CLASS METHODS
  def self.build_object usage_params
    usage = ResourceUsage.new
    usage.user_id = usage_params[:user_id].to_i
    usage.require_vcon = (usage_params[:vcon] == 'true')
    usage.require_min_distance = (usage_params[:near] == 'true')
    usage.require_double_resource = (usage_params[:double_res] == 'true')
    date = usage_params[:date]
    from_time = "#{date} #{sprintf '%02d', usage_params[:from_hrs].to_i}"
    from_time = "#{from_time}:#{sprintf '%02d', usage_params[:from_mins].to_i}"
    from_time = "#{from_time}#{usage_params[:from_am_pm] == '1' ? 'AM' : 'PM'}"
    from_time = Time.zone.parse("#{from_time} Chennai")
    usage.from_time = from_time.to_i
    to_time = "#{date} #{sprintf '%02d', usage_params[:to_hrs].to_i}"
    to_time = "#{to_time}:#{sprintf '%02d', usage_params[:to_mins].to_i}"
    to_time = "#{to_time}#{usage_params[:to_am_pm] == '1' ? 'AM' : 'PM'}"
    to_time = Time.zone.parse("#{to_time} Chennai")
    usage.to_time = to_time.to_i
    usage.resource_id = usage.get_resource_id if from_time < to_time
    return usage
  end

  # INSTANCE METHODS
  def get_resource_id
    # Check VCON requirement
    resources = Resource.all
    if require_vcon
      resources = resources.where(has_vcon: true)
    end
    # Check double resource
    if require_double_resource
      resources = resources.where.not(pair_resource_id: nil)
      other_pair_resources = Resource.where(id: resources.map(&:pair_resource_id))
      resources = resources.or(other_pair_resources)
    end
=begin
    # Commented as this section adds too much complexity
    user_priority = user.priority
    # Check minimum distance
    if require_min_distance
      urd = user.resource_distances
      urd = urd.where(distance: urd.minimum(:distance)).select("resource_id")
      resources = resources.where(id: urd.map(&:resource_id))
    end
=end
    puts resources.inspect
    resource_id = get_free_resource resources.select('id').map(&:id)
    puts "resource_id => #{resource_id}"
    return resource_id
  end

  private
    def get_free_resource resource_ids
      allocations = ResourceUsage.where(resource_id: resource_ids).select('resource_id, from_time, to_time')
      new_from_time = DateTime.strptime from_time.to_s, '%s'
      new_from_time = new_from_time.change(:offset => Time.now.zone)
      puts "resource_ids => #{resource_ids}"
      allocations.each do |allocation|
        old_from_time = DateTime.strptime allocation.from_time.to_s, '%s'
        old_from_time = old_from_time.change(:offset => Time.now.zone)
        old_to_time = DateTime.strptime allocation.to_time.to_s, '%s'
        old_to_time = old_to_time.change(:offset => Time.now.zone)
        # Conditions to collide with existing resource allocations
        #   1. From time is same as from time of an existing allocation
        #   2. From time is lesser than to time of an existing allocation
        # To time is regardless as it is always more than from time
        if new_from_time == old_from_time || new_from_time < old_to_time
          resource_ids -= [allocation.resource_id]
        end
      end
      resource_ids.first
    end
end
