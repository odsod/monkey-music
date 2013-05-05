require 'optparse'

module MonkeyMusic
  class Game

    def initialize(level, players, ui)
      @level = level
      @players = players
      @ui = ui
    end

    def start
      @level.max_turns.times do
        if @level.complete?
          break
        end
        @ui.update(@level)
        # Query players for moves
        @players.each { |p| p.query_move! }
        # Move players in random order
        @players.shuffle.each { |p| p.move! }
      end
    end

  end
end
