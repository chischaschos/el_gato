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

    attr_reader :games

    def initialize
      @games = []
    end

    def add_player player_id
      if @games.empty?
        @games << Game.new
      end

      result = @games.last.add_player(player_id)
      unless result
        @games << Game.new
        result = @games.last.add_player player_id
      end

      !!result
    end

  end
end
