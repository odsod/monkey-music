require 'optparse'

module MonkeyMusic
  class Runner

    def initialize(arguments)
      @arguments = arguments
      @opt_parser = OptionParser.new
      Config.players = []
      Config.delay = 1
      init_parser(@opt_parser)
    end

    def run
      @opt_parser.parse!
      if Config.generate_user?
        user_generator = 
          UserGenerator.new(Config.user_to_generate, 
                            Config.spotify_account, 
                            Config.spotify_password, 
                            Config.spotify_appkey)
        @user = user_generator.generate!
        puts @user.serialize
        exit
      elsif not Config.playable?
        puts @opt_parser
        exit
      end
      # Load level
      level = Level.new(Config.players, Config.user)
      level.load_from_file(Config.level_file)
      # Initialize UI
      if Config.browser_ui?
        print "Using browser UI. Press the enter key to start game. "
        gets
        puts "Starting game..."
        ui = BrowserUI.new
      else
        ui = ConsoleUI.new
      end
      # Start game
      @game = Game.new(level, Config.players, ui)
      @game.start
    end

    private

    def init_parser(opts)
      opts.banner = 'Usage: monkeymusic [options]'

      opts.on('-l',
              '--level LEVEL',
              'The level to play.') do |file|
        Config.level_file = File.join(Dir.getwd, file)
      end

      opts.on('-g',
              '--generate-user USER',
              'Generate music recommendations for a Spotify user.') do |user|
        Config.user_to_generate = user
      end

      opts.on('-f', 
              '--player-file FILE', 
              'The path to a player program.') do |file|
        Config.players << Player.new(file)
      end

      opts.on('-n', 
              '--player-name NAME', 
              'Set the name of the last entered player.') do |name|
        unless (not defined? Config.players) || Config.players.empty?
          Config.players[-1].monkey.name = name
        end
      end
      
      opts.on('-u', 
              '--user USER', 
              'The user to get recommendations from.') do |user|
        Config.user = User.read_from_file(File.join(Dir.getwd, user))
      end

      opts.on('-k', 
              '--app-key KEY', 
              'Path to libspotify application key.') do |key|
        Config.spotify_appkey = IO.read(File.join(Dir.getwd, key))
      end

      opts.on('-a', 
              '--account ACCOUNT', 
              'Username for a Spotify premium account.') do |account|
        Config.spotify_account = account
      end

      opts.on('-p', '--password PASSWORD', 
              'Password for a Spotify premium account.') do |password|
        Config.spotify_password = password
      end

      opts.on('-b', '--browser-ui', 
              'View the game through the browser instead of console.') do |password|
        Config.browser_ui = true
      end

      opts.on('-d', '--delay',
              'The delay between each round.') do |delay|
        Config.delay = delay
      end

      opts.on_tail('-h',
                   '--help', 
                   'Show this message.') do 
        puts opts
        exit
      end
    end
  end
end
