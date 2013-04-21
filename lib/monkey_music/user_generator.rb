module MonkeyMusic
  class UserGenerator

    def initialize(name, account, password, appkey_path)
      @name = name
      @account = account
      @password = password
      @appkey = IO.read(appkey_path)
    end

    def generate!
      session = Hallon::Session.initialize(@appkey)
      session.login!(@account, @password)
      user = User.new
      user_loader = UserHallonLoader.new(user, @name)
      user_loader.load_track_toplist
      user_loader.load_album_toplist
      user_loader.load_artist_toplist
      user_loader.load_recommendations_from_top_albums
      user_loader.load_recommendations_from_top_artists
      # Load some crappy(?) recommendations from Mexico
      user_loader.load_recommendations_from_country_toplist(:mx)
      sleep 1
    end
  end
end
