module ElGato
  class GameServer
    require 'drb/drb'

    # The URI for the server to connect to
    URI="druby://localhost:8787"


    def self.stop
      Process.kill 'KILL', @proccess_id
    end

    def self.start
      @proccess_id = fork do
        DRb.start_service(URI, new)
        DRb.thread.join
      end
    end

    attr_reader :waiting_players

    def initialize
      @games = []
      @waiting_players = []
    end

    def add_player player_id
      @waiting_players << BareGato::Player.new(player_id)

      if @waiting_players.size == 2
        @games << BareGato::Game.new(players: @waiting_players.dup)
        @waiting_players.clear
      end
    end

    def games player_id
      @games.find_all { |game| game.includes_player? BareGato::Player.new player_id }
    end

  end
end
