require 'optparse'
require 'hallon'

module MonkeyMusic
  module Generate
    class Runner

      def initialize
        OptionParser.new do |opts|
          opts.banner = 'Usage: monkeymusic-generate [options]'

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

          opts.on_tail('-h',
                       '--help', 
                       'Show this message.') do 
            puts opts
            exit
          end
        end.parse!
      end

      def run
        if generate_user?
          # Create user
          user = User.new
          # Connect to libspotify
          #Hallon.load_timeout = 0
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
          ## Disconnect from libspotify
          session.logout!
          # Evaluate recommendations
          puts "Evaluating recommendations..."
          score_system = ScoreSystem.new
          score_system.evaluate_user_recommendations!(user)
          # Dump and print the user
          File.open(@out_file, 'w') do |f|
            # Clean out all commas before writing
            f.write(user.dump.gsub(',', ''))
          end
          puts "====="
          puts "DONE!"
          puts "====="
          puts "Loaded tracks:"
          user.recommendations.group_by(&:tier).sort.each do |k,v| 
            puts "#Tier #{k}:\t#{v.length}"
          end
        end
      end
    
      private

      def generate_user?
        (defined? @toplist_file) &&
          (defined? @out_file) &&
          (defined? @spotify_appkey_file) &&
          (defined? @spotify_account) &&
          (defined? @spotify_password)
      end

    end
  end
end
