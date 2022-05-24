class Game < ApplicationRecord
  # Dependencies
  acts_as_paranoid

  # Relations
  has_and_belongs_to_many :players
  has_many :kills

  # Validations
  validates :total_kills, numericality: { greater_than_or_equal_to: 0 }, presence: true

  # Callbacks
  before_validation :setup_total_kills
  
  def setup_total_kills
    self.total_kills = self.kills.sum
  end
end
