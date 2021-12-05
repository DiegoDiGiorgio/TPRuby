class RepeatedValidator < ActiveModel::Validator
  def validate(record)
    if (Patiente.where(name: record.send(options[:fields][0]) , surname:record.send(options[:fields][1])).exists?)
      record.errors.add :base, "A Patient with that name and surname already exists !!"
    end
  end
end

class Patiente < ApplicationRecord
  has_many :appointments
  validates :name, presence: true, length: { maximum: 15,  minimum:3}
  validates :surname, presence: true, length: { maximum: 15,  minimum:3}
  validates :phone, presence: true
  validates_with RepeatedValidator, fields: [:name, :surname]
end
