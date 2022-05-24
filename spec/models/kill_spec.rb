require 'rails_helper'

RSpec.describe Kill, type: :model do
  let!(:world) { Player.create(name: '<world>') }
  let!(:player) { Player.create(name: 'Ilton') }
  let(:kill) { Kill.new(killer_id: world.id, killed_id: player.id, cause: Cause.name_arr('MOD_SHOTGUN')) }

  describe 'creating' do
    it 'should successfully create a kill' do
      game = Game.new
      game.save
      kill.game_id = game.id
      expect(game).to be_valid
      expect(kill).to be_valid
    end

    it 'should not create a kill' do
      kill.save
      expect(kill).to_not be_valid
    end
  end
end
