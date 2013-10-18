module ElGato
  class Game
    attr_reader :players
    def initialize
      @players = []
    end

    def add_player player
      if @players.include?(player) || @players.size == 2
        false
      else
        @players << player
      end
    end

  end
end
