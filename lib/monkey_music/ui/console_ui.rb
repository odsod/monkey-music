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
      puts "\n"
      puts "="*10
      puts "\n"
      level.players.each do |player|
        puts "#{player.monkey.name}: #{player.monkey.score}"
        puts "{ #{"0"*player.monkey.carrying.count}#{"_"*player.monkey.remaining_capacity} }\n"
      end
      sleep 0.2
    end
  end
end
