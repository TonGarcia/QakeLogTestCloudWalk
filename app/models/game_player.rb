class GamePlayer < ApplicationRecord
  # Dependencies
  acts_as_paranoid

  # Relations
  belongs_to :player
  belongs_to :game

  # Validations
  validates :player_id, presence: true
  validates :game_id, presence: true
end
