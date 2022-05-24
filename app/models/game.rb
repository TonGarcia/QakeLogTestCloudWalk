class Game < ApplicationRecord
  # Dependencies
  acts_as_paranoid

  # Relations
  has_many :kills
  has_many :game_players
  has_many :players, through: :game_players

  def name
    "game-#{id}"
  end
  
  def players_kills
    resp = {}
    world = Player.find_by(name: '<world>')
    world_id = world.id
    grouped_kills = kills.where.not(killer_id: world_id).joins(:killer).group(:killer).count
    grouped_kills.each_key do |player|
      resp[player.name] = grouped_kills[player] - kills.where(killed_id: player.id, killer_id: world_id).count 
    end
    resp
  end
  
  def kills_by_means
    resp = {}
    kills_causes = kills.group(:cause).count
    kills_causes.each_key do |kills_cause_id|
      resp[Cause.name_arr[kills_cause_id]] = kills_causes[kills_cause_id]
    end
    resp
  end
end
