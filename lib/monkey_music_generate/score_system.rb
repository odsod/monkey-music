module MonkeyMusic::Generate
  class ScoreSystem

    def evaluate_user_recommendations!(user)
      @user = user
      @top_decade = calc_top_decade(user)
      @user.recommendations.each {|track| evaluate!(track) }
      puts "The user's top decade is: #{@top_decade}."
    end

    def evaluate!(track)
      tier = 0
      if @user.toplists[:top_tracks].any? {|t| t.name == track.name }
        tier = -1
      elsif @user.toplists[:disliked_artists].any? {|ar| ar.name == track.artist }
        tier = -2
      else
        if @user.toplists[:top_albums].any? {|al| al.name == track.album }
          tier += 1
        end
        if @user.toplists[:top_artists].any? {|ar| ar.name == track.artist }
          tier += 1
        end
        if @top_decade == decade_of(track.year)
          tier += 1
        end
      end
      track.set_value(tier, 4**tier.abs * sign(tier))
    end

    private

    def calc_top_decade(user)
      decades = {}
      (user.toplists[:top_tracks] + user.toplists[:top_albums]).each do |t|
        decade = decade_of(t.year)
        decades[decade] ||= 0
        decades[decade] += 1
      end
      puts "Decade tally:"
      puts @decades.to_s
      (decades.max_by {|k,v| v }).first
    end

    def decade_of(year)
      (year % 100) / 10
    end

    def sign(num)
      num < 0 ? -1 : 1
    end

  end
end
