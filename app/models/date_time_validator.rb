class DateTimeValidator < ActiveModel::Validator
  def validate(usage_record)
    if usage_record.from_time && usage_record.to_time
      from_time = Time.zone.at usage_record.from_time
      to_time = Time.zone.at usage_record.to_time
      if (from_time.wday == 6 || from_time.wday == 0) ||
        (to_time.wday == 6 || to_time.wday == 0)

        usage_record.errors.add(:base, 'No reservations on weekends')
      end
      if from_time >= to_time
        usage_record.errors.add(:base, 'Beginning date and time must be before ending date and time')
      end
      this_date = Time.zone.now
      if (this_date + 4.weeks) < to_time
        usage_record.errors.add(:base, 'Reservation can be made only within a month(4 weeks)')
      end
      if this_date > from_time
        usage_record.errors.add(:base, 'Reservation cannot be made for past')
      end
    end
  end
end