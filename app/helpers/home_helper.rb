module HomeHelper
  def to_yes_no bool_value
    bool_value ? "Yes" : "No"
  end

  def convert_to_time_str datetime_int_value
    datetime_value = Time.zone.at datetime_int_value
    datetime_value.strftime("%d-%m-%Y %I:%M %p")
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

  def get_four_weeks monday
    options = []
    start_monday = monday
    puts ''
    while start_monday <= (monday + 4.weeks)
      end_friday = start_monday + 4.days
      options << ["#{start_monday.strftime('%d-%m-%Y')} - #{end_friday.strftime('%d-%m-%Y')}", start_monday.strftime('%Y-%m-%d')]
      start_monday += 1.week
    end
    puts options.inspect
    puts ''
    return options
  end
end
