require 'spec_helper'

module ElGato
  describe GameClient do
    before do
      GameServer.start
    end

    specify do
      game_client1 = GameClient.new
      expect(game_client1.games).to have(0).items
      expect(game_client1.play).to eq({
        status: :queued
      })
      expect(game_client1.games).to eq []

      expect { game_client1.move x: 0, y: 0 }.to raise_error 'Play a game first'

      game_client2 = GameClient.new
      expect(game_client2.games).to have(0).items
      result = game_client2.play
      expect(result[:status]).to eq :ready
      expect(result).to have_key(:id)

      expect(game_client2.games).to eq game_client1.games
      expect(game_client2.games.first[:status]).to eq :on_progress

      expect(game_client2.games).to have(1).item

      result = game_client2.play
      expect(result[:status]).to eq :ready
      expect(result).to have_key(:id)


      expect { game_client1.move x: 0, y: 0 }.to raise_error 'Play a game first'
      expect(game_client1.play[:status]).to eq :ready
      expect { game_client1.move x: 0, y: 0 }.to raise_error 'Not your turn bro!'

      expect(game_client2.move x: 0, y: 0).to be_true

    end

    after do
      GameServer.stop
    end
  end
end
