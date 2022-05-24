class Kill < ApplicationRecord
  # Dependencies
  acts_as_paranoid

  # Relations
  belongs_to :killer, class_name: 'Player'
  belongs_to :killed, class_name: 'Player'
  belongs_to :game

  # Validations
  validates :cause, numericality: { greater_than: 0, less_than: Cause.name_arr.length }, presence: true
  validates :killer_id, presence: true
  validates :killed_id, presence: true
  validates :game_id, presence: true
end
