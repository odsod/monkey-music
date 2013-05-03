module MonkeyMusic
  class ScoreSystem

    def evaluate_user_recommendations!(user)
      @user = user
      @user.recommendations.each do |track|
        track.value, track.multiplier = *evaluate(track)
      end
    end

    def evaluate(track)
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
      return [4**multiplier.abs * sign(multiplier), multiplier]
    end

    private

    def sign(num)
      num < 0 ? -1 : 1
    end

  end
end
