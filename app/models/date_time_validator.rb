class DateTimeValidator < ActiveModel::Validator
  def validate(usage_record)
    if usage_record.from_time && usage_record.to_time
      from_time = DateTime.strptime usage_record.from_time.to_s, '%s'
      to_time = DateTime.strptime usage_record.to_time.to_s, '%s'
      from_time = from_time.change(:offset => Time.now.zone)
      to_time = to_time.change(:offset => Time.now.zone)
      if (from_time.wday == 6 || from_time.wday == 7) ||
        (to_time.wday == 6 || to_time.wday == 7)

        usage_record.errors.add(:base, "No reservations on weekends")
      end
      if from_time >= to_time
        usage_record.errors.add(:base, "Time interval must be atleast 1 minute")
      end
    end
  end
end