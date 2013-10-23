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

    def play player_id
      add_player player_id

      if waiting_players.size == 2
        @games << BareGato::Game.new(players: waiting_players.dup)
        waiting_players.clear
        status = { status: :ready, id: @games.last.id }

      elsif (games = games(player_id)).size > 0
        status = :ready
        status = { status: :ready, id: games.last[:id] }

      else
        status = { status: :queued }
      end

      status
    end

    def games player_id
      @games.find_all do |game|
        game.includes_player? BareGato::Player.new player_id
      end.map do |game|
        {
          id: game.id,
          status: :on_progress
        }
      end
    end

    def move game_id, player_id, args
      game = find_game game_id
      player = BareGato::Player.new player_id

      raise 'Not your turn bro!' unless game && player && game.next?(player)

      game.play BareGato::Move.new player, args
    end

    private

    def add_player player_id
      player = BareGato::Player.new player_id
      if !waiting_players.include?(player) && games(player_id).size == 0
        waiting_players << BareGato::Player.new(player_id)
      end
    end

    def find_game game_id
      @games.find do |game|
        game.id == game_id
      end
    end

  end
end
