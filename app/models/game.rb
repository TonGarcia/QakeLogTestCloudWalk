class Game < ApplicationRecord
  # Dependencies
  acts_as_paranoid

  # Relations
  has_many :kills
  has_many :game_players
  has_many :players, through: :game_players

  def name
    "game-#{self.id}"
  end
  
  def total_kills
    begin
      self.kills.sum
    rescue
      0
    end
  end
end
