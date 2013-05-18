require 'optparse'
require 'fileutils'

module MonkeyMusic
  class Runner

    @@default_level = 'demo_level.rb'
    @@default_user = 'demo_user.yaml'
    @@default_player = 'demo_player'

    def initialize
      @opt_parser = OptionParser.new
      @players = []
      @delay = 1
      init_parser(@opt_parser)
    end

    def run(ui_class)
      if ARGV[0] == "demo"
        puts "\tcreate ./#{@@default_level}"
        FileUtils.cp(
          File.join(
            File.dirname(__FILE__), 
            "../../levels", 
            @@default_level
          ),
          Dir.getwd
        )
        puts "\tcreate ./#{@@default_user}"
        FileUtils.cp(
          File.join(
            File.dirname(__FILE__), 
            "../../users", 
            @@default_user
          ),
          Dir.getwd
        )
        puts "\tcreate ./#{@@default_player}"
        FileUtils.cp(
          File.join(
            File.dirname(__FILE__), 
            "../../", 
            @@default_player
          ),
          Dir.getwd
        )
        exit
      end
      @opt_parser.parse!
      # Handle fallback to default level
      @level_file ||= File.join(
        File.dirname(__FILE__), 
        "../../levels", 
        @@default_level
      )
      # Handle fallback to default user
      @user_file ||= File.join(
        File.dirname(__FILE__), 
        "../../users", 
        @@default_user
      )
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
      # Initialize UI
      ui = ui_class.new(@delay, level)
      # Start game
      @game = Game.new(level, @players, ui)
      @game.start
    end

    private

    def game_is_playable?
      (defined? @user_file) &&
        (defined? @level_file) &&
        (not @players.empty?)
    end

    def init_parser(opts)
      opts.banner = "Usage: monkeymusic [demo] [-p PLAYER_FILE -n PLAYER_NAME [-u USER_FILE] [-l LEVEL_FILE]]"

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

      opts.on('-c',
              '--command-line-argument ARG',
              'An argument that will be passed to the last entered program on every execution.') do |arg|
        @players[-1].command_line_argument = arg
      end

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

      opts.on('-d', '--delay DELAY', OptionParser::DecimalNumeric,
              'The delay (in seconds) between each round.') do |delay|
        @delay = delay
      end

      opts.on('-v', '--version', 
              'Show the current version.') do |password|
        puts '0.0.11' # TODO: Find out how to extract version from GemSpec
        exit
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
