class RepetedValidator < ActiveModel::Validator
  def validate(record)
    if (Appointment.where(date: record.send(options[:fields][0]) , professional_id:record.send(options[:fields][1])).exists?)
      record.errors.add :base, "Appointment at that date and time already exists !!"
    end
  end
end

class AfterTodayValidator < ActiveModel::Validator
  def validate(record)
    if (record.send(options[:fields][0]) < DateTime.now )
      record.errors.add :base, "The appointment date must be a future date !!"
    end
  end
end

class Appointment < ApplicationRecord
  validates :date, presence: true
  validates_with AfterTodayValidator, fields: [:date]
  validates_with RepetedValidator, fields: [:date, :professional_id]
  belongs_to :professional
  belongs_to :patiente
end
