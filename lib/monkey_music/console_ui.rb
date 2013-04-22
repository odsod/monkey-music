module MonkeyMusic
  class ConsoleUI

    def initialize
    end

    def msg(msg)
      puts "\e[H\e[2J"
      puts "\n"*5
      puts " "*10 + msg
      puts "\n"*5
    end
    
    def update(level)
      # Clear screen
      puts "\e[H\e[2J"
      # Level
      puts level.asciify
      # Score
      puts "="*10
      level.players.each do |player|
        puts "#{player.monkey.name}: #{player.monkey.score}"
      end
      puts "="*10
      # Events
      level.events.each do |event|
        puts event
      end
      sleep 0.5
    end
  end
end
