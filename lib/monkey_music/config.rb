require 'optparse'

module MonkeyMusic
  class Config
    class << self
      attr_accessor :level_file, :user_to_generate, :players, :user, :level,
        :spotify_app_key, :spotify_account, :spotify_password, :browser_ui, :delay

      def generate_user?
        defined? @user_to_generate && 
          defined? @spotify_account && 
          defined? @spotify_password && 
          defined? @spotify_appkey
      end

      def playable?
        defined? @user &&
          defined? @level_file &&
          defined? @players &&
          (not @players.empty?)
      end

      def browser_ui?
        defined? @browser_ui && @browser_ui == true
      end

    end
  end
end
