class DateTimeValidator < ActiveModel::Validator
  def validate(usage_record)
    if usage_record.from_time && usage_record.to_time
      from_time = Time.zone.at usage_record.from_time
      to_time = Time.zone.at usage_record.to_time
      if (from_time.wday == 6 || from_time.wday == 0) ||
        (to_time.wday == 6 || to_time.wday == 0)

        usage_record.errors.add(:base, "No reservations on weekends")
      end
      if from_time >= to_time
        usage_record.errors.add(:base, "Time interval must be atleast 1 minute")
      end
    end
  end
end