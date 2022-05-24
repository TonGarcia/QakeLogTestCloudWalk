class Kill < ApplicationRecord
  # Dependencies
  acts_as_paranoid

  # Relations
  belongs_to :player
  belongs_to :game

  # Validations
  validates :cause, length: { minimum: 1 }, presence: true
  validates :player_id, presence: true
  validates :game_id, presence: true
end
