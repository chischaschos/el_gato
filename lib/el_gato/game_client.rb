module ElGato
  class GameClient
    require 'securerandom'

    SERVER_URI="druby://localhost:8787"

    def initialize
      DRb.start_service
      @game_server = DRbObject.new_with_uri(SERVER_URI)
      @player_id = SecureRandom.uuid
      @game = add_player @player_id
    end

    def games
      @game_server.games @player_id
    end


    def add_player player_id
      @game_server.add_player player_id
    end

  end
end
