Monkey Music Challenge
======================
{: .logo}

Introduction
------------

The Spotify backend is consists of a multitude of individual services.  One such service is the music recommendation service, which is responsible for finding and recommending new tracks to Spotify users, according to their music taste.

The music recommendation service has lately been getting some pretty negative feedback from users. The word out on Twitter is that even monkeys could find better music recommendations!

Therefore, upper management has made an informed decision that the next version of the music recommendation service shall be operated entirely by monkeys. As product manager for the music recommendation service, your job is to make sure that the monkeys do a good job. 

You have therefore decided to write a computer program that helps monkeys find good track recommendations for Spotify users.

This is all entirely fictional of course. :)
{: .tip}

Task summary
------------

The task consists of implementing a program to play the Monkey Music game.
The goal of the game is to score points by gathering track recommendations
for a Spotify user.

The game
--------

The game takes place in a two dimensional level. The level is a rectangular
grid of cells.

Your program will move your monkey around the level by printing commands
to `stdout`. Before every command, your program will be fed information about the current state
of the game and level through `stdin`.

The game is divided into turns. Upon each turn, every monkey on the level gets
to execute one command. 

Before every turn, execution of your program starts. After every turn, execution of your program stops.
{: .tip}

Rules
-----

### Scoring

Your mission is to move around the level, pick up tracks, and deliver them
to a Spotify user.

Each track is worth a certain amount of points. Every time you deliver a
track, these points are added to your score. The player with the highest score 
at the end of the game is the winner.

### Turn limit

Every game is played for a limited amount of turns. This limit is different for different levels.

The game ends when the turn limit is reached.

### Time limit

Every time your program is executed, the execution time will be measured. Every level has a total time limit that your program should not exceed.

If your execution time reaches the time limit, your monkey will run out of
energy and fall asleep for `5` turns, after which your execution time will
be replenished.

### Carrying capacity

Your monkey must pick up tracks and carry them to a user. The number of
tracks your monkey can carry at any given time is called the carrying capacity.

When you have picked up enough tracks, you must deliver them to a user
before picking up more.

The carrying capacity of your monkey is different for every level.
{: .tip}

Level layout
------------

The level is a `n x m` grid of cells. 

It is sent to the standard input of your program as `m` lines, with `n`
comma-separated cells each. 

Each cell contains an ASCII string, which can be one of the following
things:


### Monkeys

**ASCII:** `M[id]`

You, and your competitors each have your own monkey to control. 
Every monkey is identified by a unique numerical id.

### Walls

**ASCII:** `#`

Walls are inanimate objects that monkeys cannot pass through.

### Tracks

**ASCII:** `spotify:track:[hash]`

Tracks are identified by their unique Spotify URI. 

Every track URI starts with `spotify:track:`, followed by `22`
alphanumerical characters:

    spotify:track:5H85hOp2oMlhMh9JlkdJP2

Tracks can be picked up and carried around by monkeys.

### User

**ASCII:** `U`

The Spotify user is where monkeys deliver their track recommendations. Monkeys are
scored for every track delivered to the user, according to how well the track fits 
the user's music taste.

### Empty

**ASCII:** `_`

Empty cells are represented by an underscore.

A cell can only contain one thing at any time.
{: .tip}

Score system
------------

Every Spotify user has a number of toplists:

* Top tracks
* Top albums
* Top artists

In the Monkey Music game, every user also has another toplist:

* Top disliked artists

How well tracks match the music taste of a user is decided by the user's toplists.

Each track belongs to one of 5 score tiers. There are three positive
tiers: `1`, `2` and `3`. There are two negative tiers, `-1` and `-2`.

If a track fulfills a negative criteria, it is immediately
placed into the corresponding tier. This differs from the positive tiers.
For every positive criteria that matches, the track climbs one tier.

The following criteria decide which tier a track belongs to:

### Tier -2: Disliked artist

The track artist is among the users's top disliked artists.

### Tier -1: Played to death

The track is already among the user's top tracks.

### Tier += 1: Favorite artist

The track artist is among the user's top artists.

### Tier += 1: Favorite album

If track album in the user's album toplist.

### Tier += 1: Favorite decade

The year of the track belongs to the user's top decade.

Every user has a top decade, which is the decade that is most prominent in the user's track toplist and album toplist.

### Tally

Your track will be scored according to it's tier:

* **Tier -2:** -16 points
* **Tier -1:** -4 points
* **Tier 1:** 4 points
* **Tier 2:** 16 points
* **Tier 3:** 64 points

Tier 3 tracks are obviously very valuable. Be on the lookout for these.
{: .tip}

Game progression
----------------

### Init phase

The first phase of the game is the init phase, which occurs once every game.

During the init phase, your program will be given information about the level that will be useful during the entire course of the game.

The information that can be read from `stdin` during the `init` phase is:

    INIT\n
    M[id]\n // id of your monkey
    [WIDTH]\n // width of the level
    [HEIGHT]\n // height of the level
    [TURN LIMIT]\n // turn limit of the game
    [n]\n // the number of entries in the track toplist
    [TRACK],[ALBUM],[ARTIST],[YEAR]\n // n rows of track metadata
    [n]\n // the number of entries in the album toplist
    [ALBUM],[ARTIST],[YEAR]\n // n rows of album metadata
    [n]\n // the number of entries in the artist toplist
    [ARTIST]\n // n rows of artist metadata
    [n]\n // the number of entries in the disliked artist toplist
    [ARTIST]\n // n rows of disliked artist metadata

After the init phase, execution of your program will stop. Make sure 
to keep the data from the init phase in a persistent cache!
{: .tip}

### Turns

After the init phase, a number of turns will follow. 

The total number of turns is decided by the turn limit of the level.

Every turn, your program will issue one command, but first it will read
the current state of the game.

The information that can be read from `stdin` during a turn is:
  
    TURN\n
    M[ID]\n // id of your monkey
    [TURN NUMBER]\n
    [REMAINING CAPACITY]\n
    [REMAINING TIME]\n
    [BOOST COOLDOWN]\n // number of turns until boost ready
    [n]\n // amount of metadata lookup results
    [URI],[TRACK],[ALBUM],[ARTIST],[YEAR]\n // n rows of metadata lookup
    results
    [CELL],[CELL],..,[CELL]\n // [height] rows of comma separated level cells

Monkey commands
---------------

Commands are sent from the standard output of your program.
In each turn of the game, every monkey executes one command. 

Commands which the monkeys can execute are:

    [MOVE] | [URI LOOKUP] | B,[COMMAND],[COMMAND],[COMMAND]

Fate decides the order in which monkeys execute their commands during a
turn.
{: .tip}

### Movement

You can command the monkey to move in the four cardinal directions using
the commands:

* **North:** `N`
* **West:** `W`
* **East:** `E`
* **South:** `S`

Each of the above command causes the monkey to attempt to move one cell in
the specified direction.

Trying to move to an already occupied cell will casue the monkey to stand
still for the duration of the round.
{: .tip}

### URI lookup

You can lookup the metadata of a track on the level by issuing a URI
lookup command:

    spotify:track:[hash]

You will recieve the result of the URI lookup in the next turn input.

Your monkey must every turn choose between moving and looking up the
metadata of a track.
{: .tip}

### Boost

    B,[COMMAND],[COMMAND],[COMMAND]

Boosting is almost as effective as barrel rolling. You can issue a boost command and then issue three other comma separated commands during the same turn.

After using boost, the command will be on cooldown before being available
for use again.

Keep a close watch on the boost cooldown, use your boost wisely!
{: .tip}

The turn input after having issued this command:

    B,W,spotify:track:5H85hOp2oMlhMh9JlkdJP2,spotify:track:5H85hOp2oMlhMh9JlkdJP2

could look like:

    TURN
    10
    M1
    1
    4529
    2
    spotify:track:5H85hOp2oMlhMh9JlkdJP2,TODO,TODO,TODO,TODO
    spotify:track:5H85hOp2oMlhMh9JlkdJP2,TODO,TODO,TODO,TODO

### Picking up tracks

When standing next to a track and executing a move command toward the track, your monkey will remain in the same cell and pick up the track. If the carrying capacity of your monkey is maxed out, nothing will happen.

Once a track is picked up, there is no way to get rid of it but to deliver it.
{: .tip}

### Delivering tracks

When standing next to the user and issuing a move command toward the track, your monkey will remain in the same cell and deliver all currently carried tracks to the user. You will then recieve score according to the score system.

Be careful about picking up negative tier tracks. You'll have to deliver them.
{: .tip}

Requirements
------------

Monkey Music depends on Ruby 1.9. 

If your OS does not provide it by default, you can always get it using RVM.

Installation
------------

To install the challenge runtime:

    > gem install monkeymusic

To get some demo code to start from:

    > monkeymusic demo

To see something on the screen:

    > monkeymusic -p demo_players/ruby/runme

You can probably reuse some of the code from the demo players.
Specifically if you do not want to spend too much time on parsing and
persisting data between rounds.

Handing in
----------

Your competition entry is to be handed in as a zip archive containing
everything needed to run your program.

When unpacked, your program should be runned through an runnable file called `runme`.

If your program requires some sort of installation, such as compilation,
this should be encoded in another runnable file called `install`.
