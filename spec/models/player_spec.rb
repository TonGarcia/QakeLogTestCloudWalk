require 'rails_helper'
require 'spec_helper'

RSpec.describe Player, type: :model do
  describe 'create' do
    it 'successfully create a player' do
      player = Player.create name: 'Ilton'
      expect(player).to be_valid
    end

    it 'should not create a player' do
      player = Player.create name: ''
      expect(player).to_not be_valid
    end
  end
end
