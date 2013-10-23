require 'spec_helper'

module ElGato
  describe GameClient do
    before do
      GameServer.start
    end

    specify do
      gc1 = GameClient.new
      gc2 = GameClient.new
      expect(gc1.games).to eq gc2.games

      gc1.play x: 0, y: 0
      gc2.play x: 1, y: 1

    end

    after do
      GameServer.stop
    end
  end
end
