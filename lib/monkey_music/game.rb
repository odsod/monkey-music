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
      # Send initial state to players
      init_threads = []
      @players.each do |p|
        init_threads << Thread.new { p.init! }
      end
      init_threads.each(&:join)
      # Start the game
      @level.turn_limit.times do |turn|
        turn += 1
        break if @level.complete?
        # Query players for moves
        query_threads = []
        turn_time = Benchmark.realtime do
          @players.each do |p|
            query_threads << Thread.new { p.query! turn }
          end
          query_threads.each(&:join)
        end
        # Move players in random order
        @players.shuffle.each { |p| p.move! }
        ## Update ui
        @ui.update(turn, turn_time)
      end
    end

  end
end
