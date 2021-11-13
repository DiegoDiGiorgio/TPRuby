class Patiente < ApplicationRecord
  has_many :appointments

  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, presence: true
end
