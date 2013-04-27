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
      @user = User.read_from_file(@user_file)
      # Load level
      @level = Level.new(@players, @user).load_from_file(@level_file)
      # Run game
      #@ui = ConsoleUI.new
      @ui = BrowserUI.new
      @level.max_turns.times do
        puts "update!"
        if @level.complete?
          @ui.msg("Complete!")
          break
        end
        @players.each { |p| p.query_move! }
        @players.each { |p| p.move! }
        @ui.update(@level)
      end
    end

    private

    def parse_options
      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: monkeymusic [options]"
        opts.on('-l', '--level LEVEL', "The level to play.") do |file|
          @level_file = File.join(Dir.getwd, file)
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
          @user_file = File.join(Dir.getwd, user)
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
      elsif !@user_file || !@level_file || @players.empty?
        puts opt_parser
        exit
      end
    end

  end
end
