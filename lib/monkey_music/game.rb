require 'optparse'

module MonkeyMusic
  class Game

    def initialize(arguments)
      @arguments = arguments
      @players = [];
    end
    
    def start
      parse_options
      # Load user
      user = User.new(@user_name)
      user.load
      # Load level
      level = Level.new(@level_name, @players, @user)
      level.load
      # Run game
      level.max_turns.times do
        puts "\e[H\e[2J"
        @players.each { |p| p.query_move! }
        @players.each { |p| p.move! }
        puts level
        sleep(0.5)
      end
    end

    private

    def parse_options
      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: monkeymusic level [options]"
        opts.on('-l', '--level LEVEL', "The level to play.") do |level_name|
          @level_name = level_name;
        end
        opts.on('--player FILE', "The path to a player program.") do |file|
          @players << Player.new(file)
        end
        opts.on('--name NAME', "Set the name of the last entered player.") do |name|
          @players[-1].monkey.name = name
        end
        opts.on('--user USER', "The user to get recommendations from.") do |user|
          @user_name = user
        end
        opts.on_tail('-h', '--help', "Show this message.") do 
          puts opts
          exit
        end
      end
      opt_parser.parse!(@arguments)
      if !@user_name || !@level_name
        puts opts
        exit
      end
    end

  end
end
