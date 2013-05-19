carrying_capacity 5
turn_limit 500
time_limit 20000
boost_cooldown 15

legend "1" => Monkey.player(1),
       "2" => Monkey.player(2),
       "a" => Track.tier(-2),
       "b" => Track.tier(-1),
       "c" => Track.tier(1),
       "d" => Track.tier(2),
       "e" => Track.tier(3),
       "U" => User,
       "#" => Wall

layout <<EOS
# c    d  #  a a  #  d    c #
## bc #  e   b#b   e  # cb ##
        d           d        
 b    e    # d d #    e    b 
  #    c    c   c    c    #  
c  c        e   e        c  c
    ##  c    1U2    c  ##    
  #   d   d   #   d   d   #  
b#  c      e b b e      c  #b
b#   ba a   ae ea   a ab   #b
 a  #                   #  a 
            #   #            
  e  a       e e       a  e  
#   #                   #   #
 b     eb  a#e e#a  be     b 
EOS
