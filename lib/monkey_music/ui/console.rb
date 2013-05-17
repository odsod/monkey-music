module MonkeyMusic::UI
  class Console

    def initialize(delay)
      @delay = delay || 1
    end

    def msg(msg)
      puts "\e[H\e[2J"
      puts "\n"*5
      puts " "*10 + msg
      puts "\n"*5
    end
    
    def update(level, turn = 0, query_time = 0)
      # Clear screen
      #puts "\e[H\e[2J"
      # Level
      puts level.to_s
      # Score
      puts "\n"
      level.players.each do |player|
        monkey = player.monkey
        puts "--- Turn: #{turn}/#{level.turn_limit} ---"
        print "#{monkey.name} | "
        print "Score: #{monkey.score} | "
        print "Time: #{player.remaining_time} | "
        puts "Capacity: #{monkey.remaining_capacity}"
        monkey.carrying.each { |t| puts "#{t.value}p: #{t.name}" }
        print("\n"*monkey.remaining_capacity)
      end
      puts "---"
      sleep [@delay - query_time, 0].max
    end
  end
end
