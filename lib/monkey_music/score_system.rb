module MonkeyMusic
  class ScoreSystem

    def initialize(user)
      @user = user
    end

    def evaluate_track(track)
      multiplier = 0
      if @user.track_toplist.include? track.name
        multiplier = -2
        track.modifiers << "Already heard!"
      elsif @user.disliked_artists.include? track.artist
        multiplier = -4
        track.modifiers << "Disliked!"
      else
        # TODO: Same album as top track
        if @user.album_toplist.include? track.album
          multiplier += 2
          track.modifiers << "Album!"
        end
        if @user.artist_toplist.include? track.artist
          multiplier += 2
          track.modifiers << "Artist!"
        end
        if @user.top_decade == decade_of(track.year)
          multiplier += 2
          track.modifiers << "Decade!"
        end
        if track.popularity >= 70
          multiplier += 2
          track.modifiers << "Super-popular!"
        elsif track.popularity >= 50
          multiplier += 1
          track.modifiers << "Popular!"
        end
        if multiplier == 0
            multiplier = -3
            track.modifiers << "Boring!"
        end
      end
      return 2**multiplier.abs * sign(multiplier)
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
