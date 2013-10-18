require 'spec_helper'

module ElGato
  describe GameClient do
    before do
      GameServer.start
    end

    specify do
      gc1 = GameClient.new
      gc2 = GameClient.new
      expect(gc1.game).to eq gc2.game
    end

    after do
      GameServer.stop
    end
  end
end
