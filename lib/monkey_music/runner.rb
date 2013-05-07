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
      if (not game_is_playable?)
        puts @opt_parser
        exit
      end
      # Load user
      user = User.new
      user.load_from_file(@user_file)
      # Load level
      level = Level.new(@players, user)
      level.load_from_file(@level_file)
      puts level.to_s
      exit
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
