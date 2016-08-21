module HomeHelper
  def to_yes_no bool_value
    bool_value ? "Yes" : "No"
  end

  def to_time_str datetime_int_value
    datetime_value = Time.zone.at datetime_int_value
    datetime_value.strftime("%I:%M %p")
  end

  def get_users users
    options = []
    users.each do |user|
      options << [user.name, user.id]
    end
    return options
  end

  def get_pair resource_usage
    if resource_usage.require_double_resource
      "#{resource_usage.resource.name}, #{resource_usage.resource.pair.name}"
    else
      resource_usage.resource.name
    end
  end
end
