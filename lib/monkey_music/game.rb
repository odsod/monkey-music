require 'optparse'

module MonkeyMusic
  class Game

    def initialize(arguments)
      @arguments = arguments
      @level_name = "";
      @players = [];
    end
    
    def start
      puts "\e[H\e[2J"
      puts "Welcome to Monkey Music!"
      parse_options
      level = Level.new(@level_name, @players)
      level.load
      puts level
      #puts @players
      #level.max_turns.times do
        #@players.query_move!
        #@players.move!
        #puts "\e[H\e[2J"
        #puts level
        #sleep(0.5)
      #end
    end

    private
    
    def parse_options
      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: monkeymusic [options]"
        opts.on('-l', '--level LEVEL', "The level to play.") do |level_name|
          @level_name = level_name;
        end
        opts.on('--player FILE', "The path to a player program.") do |file|
          @players << Player.new(file)
        end
        opts.on('--name NAME', "Set the name of the last entered player.") do |name|
          @players[-1].monkey.name = name
        end
        opts.on_tail('-h', '--help', "Show this message.") do 
          puts opts
          exit
        end
      end
      opt_parser.parse!(@arguments)
    end

  end
end
