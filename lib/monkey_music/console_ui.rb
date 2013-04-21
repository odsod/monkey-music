module MonkeyMusic
  class ConsoleUI

    def initialize
      @events = []
    end
    
    def update(level, new_events)
      # Clear screen
      puts "\e[H\e[2J"
      # Level
      puts level.asciify
      # Score
      level.players.each do |player|
        puts "#{player.monkey.name}: #{player.monkey.score}"
      end
      @events.shift(new_events.count)
      @events.push(new_events)
      sleep 0.5
    end
  end
end
