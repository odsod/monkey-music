require 'optparse'

module MonkeyMusic
  class Game

    def initialize(arguments)
      @arguments = arguments
    end
    
    def start
      parse_options
      puts "Welcome to Monkey Music!"
      turns.times do |n|
        @units.each { |unit| unit.prepare_turn }
        @units.each { |unit| unit.perform_turn }
        yield if block_given?
        @time_bonus -= 1 if @time_bonus > 0
      end
    end

    private
    
    def parse_options
      options = OptionParser.new 
      options.banner = "Usage: monkeymusic [options]"
      options.on('-l', '--level LEVEL',   "The level to play.")     { |level| Config.level = level }
      options.on('-h', '--help',          "Show this message")          { puts(options); exit }
      options.parse!(@arguments)
    end


  end
end
