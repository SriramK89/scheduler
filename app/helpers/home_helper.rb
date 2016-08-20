module HomeHelper
  def to_yes_no bool_value
    bool_value ? "Yes" : "No"
  end

  def to_time_str datetime_int_value
    datetime_value = DateTime.strptime datetime_int_value.to_s, '%s'
    datetime_value.strftime("%I:%M %p")
  end

  def get_users users
    options = []
    users.each do |user|
      options << [user.name, user.id]
    end
    return options
  end
end
