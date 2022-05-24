class Report
  # Expected response on generate:
  # {
  #   "game-1": {
  #     "total_kills": 45,
  #     "players": [
  #       "Dono da bola",
  #       "Isgalamido",
  #       "Zeh"
  #     ],
  #     "kills": {
  #       "Dono da bola": 5,
  #       "Isgalamido": 18,
  #       "Zeh": 20
  #     }
  #     "kills_by_means": {
  #       "MOD_SHOTGUN": 10,
  #       "MOD_RAILGUN": 2,
  #       "MOD_GAUNTLET": 1,
  #       ...
  #     }
  #   }
  # }
  def self.generate
    response = {}
    world = Player.where(name: '<world>').take
    world_id = world.id
    
    # batch processing loop
    Game.all.find_each do |game|
      response[game.name] = {
        total_kills: game.kills.count,
        players: game.players.where.not(id: world_id).pluck(:name),
        kills: game.players_kills,
        kills_by_means: game.kills_by_means
      }
    end
    
    response
  end
end