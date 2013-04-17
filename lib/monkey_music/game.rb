module MonkeyMusic
  class Game
    
    def start
      UI.puts "Welcome to Monkey Music!"
      play_level
    end
    
    def play_level
      current_level.load_player
      current_level.play
    end
    
  end
end
