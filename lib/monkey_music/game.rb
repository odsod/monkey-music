require 'optparse'

module MonkeyMusic
  class Game

    def initialize(arguments)
      @arguments = arguments
      @level_name = "";
    end
    
    def start
      parse_options
      puts "Welcome to Monkey Music!"
      level = Level.new(@level_name).load
      level.max_turns.times do |n|
        level.monkeys.each
      end
      turns.times do |n|
        @units.each { |unit| unit.prepare_turn }
        @units.each { |unit| unit.perform_turn }
        yield if block_given?
        @time_bonus -= 1 if @time_bonus > 0
      end
    end

    private
    
    def parse_options
      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: monkeymusic [options]"
        opts.on('-l', '--level LEVEL', "The level to play.") do |level_name|
          @level_name = level_name;
        end
        opts.on_tail('-h', '--help', "Show this message.") do 
          puts puts
          exit
        end
      end
      opt_parser.parse!(@arguments)
    end

  end
end
