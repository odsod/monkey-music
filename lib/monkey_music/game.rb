require 'optparse'
require 'benchmark'

module MonkeyMusic
  class Game

    def initialize(level, players, ui)
      @level = level
      @players = players
      @ui = ui
    end

    def start
      @ui.update(@level)
      @level.max_turns.times do
        if @level.complete?
          break
        end
        # Query players for moves
        query_threads = []
        query_time = Benchmark.realtime do
          @players.each do |p|
            query_threads << Thread.new do
              p.query_move!
            end
          end
          query_threads.each(&:join)
        end
        # Move players in random order
        @players.shuffle.each { |p| p.move! }
        # Update ui
        @ui.update(@level, query_time)
      end
    end

  end
end
