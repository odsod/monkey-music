require 'optparse'

module MonkeyMusic
  class Runner

    def initialize(arguments)
      @arguments = arguments
      @opt_parser = OptionParser.new
      @players = []
      @delay = 1
      init_parser(@opt_parser)
    end

    def run
      @opt_parser.parse!
      if generate_user?
        # Create user
        user = User.new
        # Connect to libspotify
        Hallon.load_timeout = 0
        session = Hallon::Session.initialize(IO.read(@spotify_appkey_file))
        session.login!(@spotify_account, @spotify_password)
        # Load toplists
        puts "Loading toplists from #{@toplist_file}..."
        toplist_loader = ToplistLoader.new(@toplist_file)
        toplist_loader.load_for_user!(user)
        # Generate recommendations
        puts "Loading recommendations..."
        loaded_toplists = toplist_loader.loaded_toplists
        recommendation_loader = RecommendationLoader.new(loaded_toplists)
        recommendation_loader.load_for_user!(user)
        # Disconnect from libspotify
        session.logout!
        # Evaluate recommendations
        puts "Evaluating recommendations..."
        score_system = ScoreSystem.new
        score_system.evaluate_user_recommendations!(user)
        # Dump and print the user
        File.open(@out_file, 'w') do |f|
          f.write(user.dump)
        end
        exit
      elsif not game_is_playable?
        puts @opt_parser
        exit
      end
      # Load user
      user = User.new
      user.load_from_file(@user_file)
      # Load level
      level = Level.new(@players, user)
      level.load_from_file(@level_file)
      ## Initialize UI
      if browser_ui?
        print "Using browser UI. Press the enter key to start game. "
        gets
        puts "Starting game..."
        ui = BrowserUI.new(@delay)
      else
        ui = ConsoleUI.new(@delay)
      end
      ## Start game
      @game = Game.new(level, @players, ui)
      @game.start
    end

    private

    def generate_user?
      (defined? @toplist_file) &&
        (defined? @out_file) &&
        (defined? @spotify_appkey_file) &&
        (defined? @spotify_account) &&
        (defined? @spotify_password)
    end

    def game_is_playable?
      (defined? @user_file) &&
        (defined? @level_file) &&
        (not @players.empty?)
    end

    def browser_ui?
      @browser_ui == true
    end

    def init_parser(opts)
      opts.banner = 'Usage: monkeymusic [options]'

      opts.on('-l',
              '--level LEVEL',
              'The level to play.') do |file|
        @level_file = File.join(Dir.getwd, file)
      end
      
      opts.on('-u',
              '--user USER',
              'The user the players will recommend music for.') do |user|
        @user_file = File.join(Dir.getwd, user)
      end

      opts.on('-p',
              '--player FILE',
              'The path to a player program.') do |file|
        player_file = File.join(Dir.getwd, file)
        @players << Player.new(player_file)
      end

      opts.on('-n',
              '--player-name NAME', 
              'Set the name of the last entered player.') do |name|
        @players[-1].monkey.name = name unless @players.empty?
      end

      opts.on('-d', '--delay DELAY', OptionParser::DecimalNumeric,
              'The delay (in seconds) between each round.') do |delay|
        @delay = delay
      end

      opts.on('-g',
              '--generate TOPLIST_FILE',
              'Generate a user from a toplist file.') do |user|
        @toplist_file = File.join(Dir.getwd, user)
      end

      opts.on('-o',
              '--out OUT_FILE',
              'The file to dump a generated user to.') do |file|
        @out_file = File.join(Dir.getwd, file)
      end

      opts.on('-k', 
              '--app-key KEY', 
              'Path to libspotify application key.') do |key|
        @spotify_appkey_file = File.join(Dir.getwd, key)
      end

      opts.on('-a', 
              '--account ACCOUNT', 
              'Username for a Spotify premium account.') do |account|
        @spotify_account = account
      end

      opts.on('-w', '--password PASSWORD', 
              'Password for a Spotify premium account.') do |password|
        @spotify_password = password
      end

      opts.on('-b', '--browser-ui', 
              'View the game through the browser instead of the console.') do |password|
        @browser_ui = true
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
