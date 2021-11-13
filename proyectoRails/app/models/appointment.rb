class Appointment < ApplicationRecord
  validates :date, presence: true
  belongs_to :professional
  belongs_to :patiente
end
