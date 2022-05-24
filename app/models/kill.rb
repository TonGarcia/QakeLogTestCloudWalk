class Kill < ApplicationRecord
  # Dependencies
  acts_as_paranoid

  # Relations
  belongs_to :player
  belongs_to :game

  # Validations
  validates :cause, numericality: { greater_than: 0, less_than: Cause.name_arr.length }, presence: true
  validates :player_id, presence: true
  validates :game_id, presence: true
end
