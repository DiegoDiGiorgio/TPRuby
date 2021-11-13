class Professional < ApplicationRecord
  has_many :appointments
  
  validates :name, presence: true
  validates :surname, presence: true
end
