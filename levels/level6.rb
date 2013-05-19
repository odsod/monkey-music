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
      a     c# #c     a      
   cc #  d #     # d  # cc   
 #       e  #   #  e       # 
     e                 e     
   b ea    a     a    ae b   
c   b ##      #      ## b   c
    #  #     a a     #  #    
  b de b   d     d   b ed b  
     c ec  ae   ea  ce c     
        #d#       #d#        
e      ed           de      e
 #  e      e a a e      e  # 
   bc#     a     a     #cb   
c        d#e 1U2 e#d        c
#      e  #       #  e      #
EOS
