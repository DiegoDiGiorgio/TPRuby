class RepeatedValidator < ActiveModel::Validator
  def validate(record)
    if (Patiente.where(name: record.send(options[:fields][0]) , surname:record.send(options[:fields][1])).exists?)
      record.errors.add :base, "A Patient with that name and surname already exists !!"
    end
  end
end

class Patiente < ApplicationRecord
  has_many :appointments

  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, presence: true
  validates_with RepeatedValidator, fields: [:name, :surname]
end
