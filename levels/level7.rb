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
         a #     # a         
  ##   c             c   ##  
        abe       eba        
  c d# b    b # b    b #d c  
  #      cbe  #  ebc      #  
#        #  #   #  #        #
b c   c     # # #     c   c b
# d #    d         d    # d #
  cd #  a           a  # dc  
       #  b       b  #       
b##dbde               edbd##b
#   b     #  1U2  #     b   #
     # #c   ## ##   c# #     
b   ca b#  #c# #c#  #b ac   b
 d#  ed    #     #    de  #d 
EOS
