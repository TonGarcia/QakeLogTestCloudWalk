require 'rails_helper'
require 'spec_helper'

RSpec.describe GamePlayer, type: :model do
  describe "Associations" do
    it "should belongs to a game" do should belong_to(:game) end 
    it "should belongs to a player" do should belong_to(:player) end
  end
end
