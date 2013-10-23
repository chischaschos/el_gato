module ElGato
  class GameClient
    require 'securerandom'

    SERVER_URI="druby://localhost:8787"

    def initialize
      DRb.start_service
      @game_server = DRbObject.new_with_uri(SERVER_URI)
      @player_id = SecureRandom.uuid
    end

    def games
      @game_server.games @player_id
    end

    def add_player
      @game_server.add_player @player_id
    end

    def play
      result = @game_server.play @player_id
      @current_game_id = result[:id] if result[:status] == :ready
      result
    end

    def move args
      raise 'Play a game first' unless @current_game_id

      @game_server.move @current_game_id, @player_id, args
    end
  end
end
