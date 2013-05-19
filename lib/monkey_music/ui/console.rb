module MonkeyMusic::UI
  class Console

    def initialize(level, players, delay = 1, clear = true)
      @clear = clear
      @delay = delay
      @players = players
      @level = level
      print "Using console UI. Press the enter key to start game."
      gets
    end

    def update(turn = 0, turn_time = 0)
      # Clear screen
      puts "\e[H\e[2J" if @clear
      # Level
      puts @level.to_s
      # Score
      puts "\n"
      @players.each do |player|
        monkey = player.monkey
        puts "--- Turn: #{turn}/#{@level.turn_limit} ---"
        print "#{monkey.name} | "
        print "Score: #{monkey.score} | "
        print "Time: #{player.remaining_time} | "
        puts "Capacity: #{monkey.remaining_capacity}"
        monkey.carrying.each { |t| puts "#{t.value}p: #{t.name}" }
        print("\n"*monkey.remaining_capacity)
      end
      puts "---"
      sleep [@delay - turn_time, 0].max
    end
  end
end
