class Player < ApplicationRecord
  # Dependencies
  acts_as_paranoid

  # Relations
  has_and_belongs_to_many :games

  # Validations
  validates :name, length: { minimum: 1 }, presence: true
end
