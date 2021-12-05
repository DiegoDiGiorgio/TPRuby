class RepeatedValidator < ActiveModel::Validator
  def validate(record)
    if (Professional.where(name: record.send(options[:fields][0]) , surname:record.send(options[:fields][1])).exists?)
      record.errors.add :base, "A Professional with that name and surname already exists !!"
    end
  end
end



class Professional < ApplicationRecord
  has_many :appointments
  
  validates :name, presence: true, length: { maximum: 15,  minimum:3}
  validates :surname, presence: true, length: { maximum: 15,  minimum:3}
  validates_with RepeatedValidator, fields: [:name, :surname]
end
