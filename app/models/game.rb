class Game < ApplicationRecord
  # Dependencies
  acts_as_paranoid

  # Relations
  has_and_belongs_to_many :players
  has_many :kills

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
