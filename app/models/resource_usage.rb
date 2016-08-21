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
    from_time = Time.zone.parse(usage_params[:from_date])
    usage.from_time = from_time.to_i
    to_time = Time.zone.parse(usage_params[:to_date])
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
    resource_id = get_free_resource resources.select('id').map(&:id)
    return resource_id
  end

  private
    def get_free_resource resource_ids
      allocations = ResourceUsage.where(resource_id: resource_ids).select('resource_id, from_time, to_time')
      new_from_time = Time.zone.at from_time
      new_from_time = new_from_time.change(:offset => Time.now.zone)
      allocations.each do |allocation|
        old_from_time = Time.zone.at allocation.from_time
        old_from_time = old_from_time.change(:offset => Time.now.zone)
        old_to_time = Time.zone.at allocation.to_time
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
