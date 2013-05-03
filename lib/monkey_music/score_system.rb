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
      if @user.toplists[:tracks].include? track.name
        multiplier = -1
      elsif @user.toplists[:disliked].include? track.artist
        multiplier = -2
      else
        if @user.toplists[:albums].include? track.album
          multiplier += 1
        end
        if @user.toplists[:albums].include? track.album
          multiplier += 1
        end
        if @user.toplists[:artists].include? track.artist
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
