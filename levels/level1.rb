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
                   b    e  d # d  e    b                   
##d  ######   ###    ###  # c#c #  ###    ###   ######  d##
# #    ######   # # #######     ####### # #   ######    # #
bc ## ##  ### ### #d eb ## ## ## ## be d# ### ###  ## ## cb
  #    ## ##   # #   #a # c 1U2 c # a#   # #   ## ##    #  
#   #b     #      ##   #   #   #   #   ##      #     b#   #
# # e  # #  #  #    ## ###   #   ### ##    #  #  # #  e # #
# #    ##    # #     # ##  #   #  ## #     # #    ##    # #
# #  # ##  #  #  ##d  ### ## # ## ###  d##  #  #  ## #  # #
 a# #####  #  # ##     ## ##   ## ##     ## #  #  ##### #a 
d##  b##  #   ###  # a#####     #####a #  ###   #  ##b  ##d
 ###c###  # ##  ##  #  # #e  #  e# #  #  ##  ## #  ###c### 
 ## d #d##  ##  ##  ## #  ##   ##  # ##  ##  ##  ##d# d ## 
##eb# #     ##    # ### #a   #   a# ### #    ##     # #be##
## #a  #   ##e#  # ## e a  #   #  a e ## #  #e##   #  a# ##
#   #   ## a   #   ####    #b#b#    ####   #   a ##   #   #
 b# ## ##  # #a  #   b  # #  #  # #  b   #  a# #  ## ## #b 
# #   #  e #   ##d  ###    # # #    ###  d##   # e  #   # #
#d#d ## #   ####   #ae## # # # # # ##ea#   ####   # ## d#d#
  # ##  # e #   ##  b     #     #     b  ##   # e #  ## #  
    b   # #    ### # #  # ##   ## #  # # ###    # #   b    
 # # #c  #  ## #   ### ##  ## ##  ## ###   # ##  #  c# # # 
## # ## ## e # ##     #  # ##### #  #     ## # e ## ## # ##
  ###   #  #  ### ### #    #####    # ### ###  #  #   ###  
# # ## ## ### ### ##   ##    #    ##   ## ### ### ## ## # #
b   ###     #   #  ### #  ##   ##  # ###  #   #     ###   b
# ##     #  # # ##    ###a### ###a###    ## # #  #     ## #
#d# # #  ##a   #   ###   #c     c#   ###   #   a##  # # #d#
    #  #   ###  ##   ###   ## ##   ###   ##  ###   #  #    
#       ##    ##   ####  ###   ###  ####   ##    ##       #
EOS
