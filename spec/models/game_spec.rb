require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'creating' do
    it 'should successfully create a game' do
      game = Game.new
      game.save
      expect(game).to be_valid
    end
  end
end
