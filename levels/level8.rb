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
  a #   #  e     e  #   # a  
  #b c       1U2       c b#  
 d# c#  dc   e e   cd  #c #d 
        a           a        
## # #  ece       ece  # # ##
    eb b             b be    
           c     c           
d     aeb ca     ac bea     d
   e #     b # # b     # e   
        ##         ##        
 c     a  #  b b  #  a     c 
 # e  e ##   d d   ## e  e # 
  d  #c  c  d# #d  c  c#  d  
  e    #             #    e  
  #      #   c c   #      #  
EOS
