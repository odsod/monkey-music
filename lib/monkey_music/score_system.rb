module MonkeyMusic
  class ScoreSystem

    def initialize(user)
      @user = user
    end

    def evaluate_track(track)
      multiplier = 0
      if @user.track_toplist.include? track.name
        multiplier = -1
      elsif @user.disliked_artists.include? track.artist
        multiplier = -2
      else
        if @user.track_toplist_albums.include? track.album
          multiplier += 1
        end
        if @user.album_toplist.include? track.album
          multiplier += 1
        end
        if @user.artist_toplist.include? track.artist
          multiplier += 1
        end
      end
      return 4**multiplier.abs * sign(multiplier)
    end

    private

    def sign(num)
      num < 0 ? -1 : 1
    end

    def decade_of(year)
      (year % 100) / 10
    end

  end
end
