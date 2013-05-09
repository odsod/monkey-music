<img src="documents/logo.png" />

Welcome to the Monkey Music Challenge.

Quick start
-----------

To install the challenge runtime:

```
gem install monkeymusic
```

To get started quickly:

```
monkeymusic demo
```

To see something on the screen:

```
monkeymusic -p demo_player
```

You can probably learn a lot about the game from reading the `demo_player`.

Also make sure to read the protocol examples at the end of the document.

The level
---------

Your monkey moves around in a flat 2D level. You can think of the level as
a matrix, where any square can be occupied by one thing at any given time.

```
 Xl     1 U 2     lX 
t    ll       ll    t
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
```

Every monkey is represented in the level by a numerical id:

* *Monkey*: `\d`

Besides monkeys, the level can also contain:

* *Tracks*: `spotify:track:......................`
* *Walls*: `#`
* *The User*: `U`

Your monkey has one mission: to find and deliver suitable track 
recommendations to *The User*.

The user
--------

To help you figure out what tracks to recommend to your *User*, you have
access to the following of your user's toplists:

* *Top tracks*: `[(track,artist,album,year)]`
* *Top albums*: `[(album,artist,year)]`
* *Top artists*: `[(artist)]`

You also have a list of what the user does not like:

* *Top disliked artists*: `[(artist)]`

The monkey
----------

A monkey can move between squares in the four cardinal directions:

* *North*: `N`
* *West*: `W`
* *East*: `E`
* *South*: `S`

Your monkey can carry a specific amount of tracks at any given time, this
is referred to as the `capacity` of your monkey. 

To stand next to a *Track* and move towards it is to pick it up, provided that the monkey has remaining `capacity`.

To stand next to a *User* and move towards it is to `deliver` all curretly
carried tracks to the user. Your monkey will then score points according
to how well the tracks fit the user's music taste. 

After delivering tracks, your monkey will once again be at full `capacity`.

The scores
----------

To decide how well a *Track* fits the music taste of a *User*, every track
is put into one of 5 different score tiers.

2 of these tiers are negative tiers. You don't want your monkey picking up
and delivering tracks from these tiers. 

The following criteria decide which tier any given track belongs to:

### Tier -2: Disliked artist

To recommend a track whose `artist` is among the user's *Top disliked
artists* is simply an epic fail.

### Tier -1: "Sönderlyssnad" 

When the `track` is already among the user's *Top tracks*, there is not much
point in recommending it, is there?

### Tier += 1: Favorite artist

If the `artist` of the track is among the user's *Top artists*, the track
will be bumped up one tier.

### Tier += 1: Favorite album

If the `album` of the track is among the user's *Top albums*, the track
will be bumped up one tier.

### Tier += 1: Favorite decade

This is an interesting one. Every user has a *Top decade*, which is the
decade that is most prominent among the user's *Top tracks* and 
*Top albums*.

If the `year` of the track belongs to the user's *Top decade*, the track
will be bumped up one tier.

### Tally

Your track will be scored according to it's tier:

* *Tier -2*: -16 points
* *Tier -1*: -4 points
* *Tier 1*: 4 points
* *Tier 2*: 16 points
* *Tier 3*: 64 points

*Tier 3* tracks are obviously very valuable, so be on the lookout for
these.

Once a *Track* is picked up, there is no way to get rid of it but to
`deliver` it to the *User*, so make sure to stay away from negative tier
tracks.

The game
--------

Every game is broken up into a number of turns. Every `turn`, your
program will be fed information about the current state of the level, by
reading from `stdin`. Your program responds by printing one `command`,
to `stdout`, telling your *Monkey* what to do during the current turn.

If there are more that one *Monkey* in the level, `fate` will decide which
monkey gets to carry out its command first.

The game consists of two `phases`.

### Init phase

During the `init` phase, your program will read information about 
the level that will be useful during the entire course of the game.

The information that can be read from `stdin` during the `init` phase is:

* The numerical `id` of your *Monkey*
* The `width` of the map
* The `height` of the map
* The `turn limit` of the game
* The `toplists` of the *User*.

### Turn phase

After the `init` phase, a number of `turn` phases will follow.

The information that can be read from `stdin` during the `turn` phase is:

* The `turn number` (1 - `turn limit`)
* The current `capacity` of your monkey `(>= 0)`
* The `remaining time` your program can run before `penalty`.

That's right, your program will only be allowed to run for a certain
amount of time during the course of the game. When your `remaining time`
is depleted, your *Monkey* will fall asleep for 5 turns, after which your
`remaining time` will be replenished.

The commands
------------

Every `turn`, you can issue one `command` to your *Monkey*.

### Movement commands

The following commands will result in your *Monkey* attempting to move in
the specified direction. The move will succeed if the adjacent square is
empty, or if the move results in the *Monkey* picking up a *Track* or
deliverings tracks to the *User*.

* Move north: `N`
* Move west: `W`
* Move east: `E`
* Move south: `S`

### Lookup command

Instead of moving, you can every round do a `lookup` to get `metadata` on 
a *Track*. You will need the metadata for a track to calculate which
`tier` it belongs to.

To do a lookup, simply print the `uri` of the track to `stdout`.

* Lookup: `spotify:track:......................`

### Boost command

Once every game, you can issue one `boost` command, and then issue 3 other
commands that will be carried out during that round.

The stdin protocol
------------------

### Diagram

<p style="text-align: center">
  <img src="documents/stdinflow.png" />
</p>

### Init phase

<div style="font-size: 80%;">
```
INIT 
9 // Monkey id
11 // Level width
11 // Level height
100 // Turn limit
10 // Number of top tracks
Condemnation,Depeche Mode,Songs Of Faith And Devotion,1993
Enola Gay - 2003 - Remaster,Orchestral Manoeuvres In The Dark,Organisation,2003
The Fog Rose High,Craft Spells,Idle Labor,2011
Cars,Gary Numan,Premier Hits,1981
Tainted Love,Soft Cell,Tainted Love / Where Did Our Love Go,2009
You Surround Me,Erasure,Wild!,1989
Something New,Girls Aloud,Something New,2012
Guilty Partner,New Order,Technique [Collector's Edition],2008
The New Stone Age - 2003 Digital Remaster,Orchestral Manoeuvres In The Dark,Architecture And Morality,2003
Don't Go,Yazoo,Upstairs At Eric's,1982
10 // Number of top albums
Delta Machine,Depeche Mode,2013
Architecture And Morality,Orchestral Manoeuvres In The Dark,2003
Replicas,Tubeway Army,1979
Vienna,Ultravox,2008
Hits The Very Best Of Erasure,Erasure,2003
Tainted Love / Where Did Our Love Go,Soft Cell,2009
The Best Of New Order,New Order,1994
Witching Hour,Ladytron,2007
Nightdrive With You,Anoraak,2008
Boxed,Eurythmics,2005
10 // Number of top artists
Depeche Mode
Orchestral Manoeuvres In The Dark
The Human League
New Order
The Postal Service
Kraftwerk
Gary Numan
MGMT
M83
Duran Duran
5 // Number of disliked artists
Misfits
The Ramones
Bad Religion
The Clash
Sex Pistols
```
</div>

### Turn phase

<div style="font-size: 80%;">
```
TURN
1 // Turn number
3 // Remaining capacity
10000 // Remaining runtime (ms)
_,_,_,_,_,_,_,_,_,_,_
_,W,W,_,_,_,_,_,W,W,_
_,W,spotify:track:5H85hOp2oMlhMh9JlkdJP2,_,_,_,_,_,spotify:track:3NYCaxkggl0Hh8vQptSUvV,W,_
_,_,_,_,_,_,_,spotify:track:3qAEEfC57OI4SCuj7Zk5va,_,_,_
9,_,_,_,_,_,_,_,_,_,_
_,_,_,spotify:track:4CARtDIJS87fOmWb1RxLKK,_,_,_,_,_,_,U
_,_,_,_,_,_,_,_,_,_,_
_,_,_,_,_,_,_,spotify:track:1ARZpuJ5KjxvmsFU4NryQH,_,_,_
_,W,spotify:track:0S8LgLoseDB6W2HWd1ym6P,_,_,_,_,_,spotify:track:3NwaVr6RJg2LPBcJ1Ysl1O,W,_
_,W,W,_,_,_,_,_,W,W,_
_,_,_,_,_,_,_,_,_,_,_
```
</div>

The stdout protocol
-------------------

### Movement

```
W
```

### Lookup

The following is printed to `stdout`:

```
spotify:track:0S8LgLoseDB6W2HWd1ym6P
```

Then the following can be read from `stdin`:

```
1
spotify:track:0S8LgLoseDB6W2HWd1ym6P,Condemnation,Depeche Mode,Songs Of Faith And Devotion,1993
```

If the lookup failed:

```
0
```

Remember to flush the output buffers!

### Boost

The letter `B` followed by a comma-separated lists of other commands:

```
B,W,spotify:track:4CARtDIJS87fOmWb1RxLKK,spotify:track:0S8LgLoseDB6W2HWd1ym6P
```

Then the monkey will move `west` and the following can be read from
`stdin`:

```
2
spotify:track:0S8LgLoseDB6W2HWd1ym6P,Condemnation,Depeche Mode,Songs Of Faith And Devotion,1993
spotify:track:4CARtDIJS87fOmWb1RxLKK,The Fog Rose High,Craft Spells,Idle Labor,2011
```
