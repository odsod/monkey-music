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
      #user = User.new(@user_name)
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
        opts.banner = "Usage: monkeymusic [options]"
        opts.on('-l', '--level LEVEL', "The level to play.") do |level_name|
          @level_name = level_name;
        end
        opts.on('-g', '--generate-user USER', "Generate music recommendations for a Spotify user.") do |user|
          @generate_user = user
        end
        opts.on('-f', '--player-file FILE', "The path to a player program.") do |file|
          @players << Player.new(file)
        end
        opts.on('-n', '--player-name NAME', "Set the name of the last entered player.") do |name|
          @players[-1].monkey.name = name
        end
        opts.on('-u', '--user USER', "The user to get recommendations from.") do |user|
          @user_name = user
        end
        opts.on('-k', '--app-key KEY', "Path to libspotify application key.") do |key|
          @app_key = File.join(Dir.getwd, key)
        end
        opts.on('-a', '--account ACCOUNT', "Username for a Spotify premium account.") do |account|
          @account = account
        end
        opts.on('-p', '--password PASSWORD', "Password for a Spotify premium account.") do |password|
          @password = password
        end
        opts.on_tail('-h', '--help', "Show this message.") do 
          puts opts
          exit
        end
      end
      opt_parser.parse!(@arguments)
      if @generate_user && @account && @password && @app_key
        @user = UserGenerator.new(@generate_user, @account, @password, @app_key).generate!
        puts @user.serialize
        exit
      elsif !@user_name || !@level_name
        puts opt_parser
        exit
      end
    end

  end
end
