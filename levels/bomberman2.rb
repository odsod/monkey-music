carrying_capacity 5
metadata_requests_per_turn 2
max_turns 100

legend({ 
  "1" => Monkey.player(1),
  "2" => Monkey.player(2),
  "X" => Track.worth(-2),
  "x" => Track.worth(-1),
  "l" => Track.worth(1),
  "t" => Track.worth(2),
  "T" => Track.worth(3),
  "U" => User,
})

layout <<LAYOUT
 Xl       U       lX 
t    ll  1 2  ll    t
###t ########### t###
#t # #T tlTlt T# # t#
##   #T#l   l#T#   ##
#l ######X X###### l#
##  #   # x #   #  ##
#T#   #t#   #t#   #T#
#x#l##### # #####l#x#
#   #   # l #   #   #
### # # # # # # # ###
#t    #   #   #    t#
#l###l#t#t#t#t#l###l#
LAYOUT
