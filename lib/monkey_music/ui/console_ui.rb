module MonkeyMusic
  class ConsoleUI

    def initialize(delay)
      @delay = delay || 1
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
      puts level.to_s
      # Score
      puts "\n"
      level.players.each do |player|
        monkey = player.monkey
        puts "---"
        print "#{monkey.name} | "
        print "Score: #{monkey.score} | "
        puts "Capacity: #{monkey.remaining_capacity}"
        monkey.carrying.each { |t| puts "#{t.value}p: #{t.name}" }
        print("\n"*monkey.remaining_capacity)
      end
      puts "---"
      sleep @delay
    end
  end
end
