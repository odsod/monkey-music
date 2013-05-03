module MonkeyMusic
  class ScoreSystem

    def evaluate_user_recommendations!(user)
      @user = user
      @user.recommendations.each { |track| evaluate!(track) }
    end

    def evaluate!(track)
      multiplier = 0
      if @user.toplists[:top_tracks].include? track.name
        multiplier = -1
      elsif @user.toplists[:disliked].include? track.artist
        multiplier = -2
      else
        if @user.toplists[:top_albums].include? track.album
          multiplier += 1
        end
        if @user.toplists[:top_artists].include? track.artist
          multiplier += 1
        end
        if @user.toplists[:top_track_albums].include? track.album
          multiplier += 1
        end
      end
      track.multiplier = multiplier
      track.value = 4**multiplier.abs * sign(multiplier)
    end

    private

    def sign(num)
      num < 0 ? -1 : 1
    end

  end
end
