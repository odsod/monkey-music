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
      # Send initial state to players
      init_threads = @players.each do |p|
        query_threads << Thread.new do
          p.init!
        end
      end
      init_threads.each(&:join)
      # Start the game
      @level.max_turns.times do |turn|
        break if @level.complete?
        # Query players for moves
        query_threads = []
        query_time = Benchmark.realtime do
          @players.each do |p|
            query_threads << Thread.new { p.query! }
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
