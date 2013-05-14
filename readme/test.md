<img class="logo" src="documents/logo.png" />

Introduction
============

The Spotify backend is consists of a multitude of individual services.
One such service is the music recommendation service, which is responsible
for finding and recommending new tracks to Spotify users, according to their taste in music.

The music recommendation service has lately been getting some pretty negative feedback
from users. The word out on Twitter is that even monkeys could find better music recommendations!

Therefore, upper management has made an informed decision that the next version of the music recommendation
service shall be operated entirely by monkeys. As product manager for the music recommendation service, your job is to make sure that the monkeys do a good job. 

You have therefore decided to write a computer program that helps monkeys find good track recommendations for Spotify users.

This is all entirely fictional of course.
{: .tip}

Task summary
============

The task consists of implementing a program to move a monkey around a level. The monkey's mission is 
to score points by gathering track recommendations and giving them to a Spotify user. 

Level layout
------------

The level is a `n x m` grid of cells. It is sent to the standard input of your program. 

Each cell contains one of the following things:

Monkeys
: ASCII: `M[id]`
: You, and your competitors each have your own monkey to control. 
: Every monkey is identified by a unique numerical id.

Walls
: ASCII: `#`
: Walls are inanimate objects that monkeys cannot pass through.

Tracks
: ASCII: `[URI]`
: Tracks are identified by their unique Spotify URI. Every track URI starts with `spotify:track:`, 
: followed by `22` alphanumerical characters. Example: `spotify:track:5H85hOp2oMlhMh9JlkdJP2`.
: Tracks can be picked up and carried around by monkeys.

The User
: ASCII: `U`
: The user is where monkeys deliver their track recommendations. Monkeys are scored for every track
: delivered to the user according to how well the track fits the user's music taste.

Empty
: ASCII: `[SPACE]`
: Nothing to do here.

Any given cell can only contain one thing at any time.
{: .tip}

Monkey movement
---------------

Commands are sent from the standard output of your program. 
In each turn of the game, every monkey executes one command. 

Commands which the monkeys can execute are:

Move west
: ASCII: `W`
: Moves the monkey one cell to the left.

Move east
: ASCII: `E`
: Moves the monkey one cell to the right.

Move north
: ASCII: `N`
: Moves the monkey one cell up.

Move down
: ASCII: `N`
: Moves the monkey one cell down.

Metadata lookup
: ASCII: `[URI]`
: Queries the metadata for a track URI. 
: After issuing this command, your program will immediately receive a response
: via its standard input. The response will be one line consisting of one integer `n`, saying 
: how many queries succeeded. The following `n` lines will contain metadata for the requested tracks.

Boost
: ASCII: `B,[COMMAND],[COMMAND],[COMMAND]`
: Once every game, the monkey can issue a boost command and then issue three
: other comma separated commands during the same turn.

Your monkey must every turn choose between moving and looking up the metadata of a track!
{: .tip}

Quick start
===========

To install the challenge runtime:

    > gem install monkeymusic

To get started quickly:

    > monkeymusic demo

To see something on the screen:

    > monkeymusic -p demo_player

You can probably learn a lot about the game from reading the `demo_player`.

Also make sure to read the protocol examples at the end of the document.

Metadata fields are separated by double commas! (`,,`)
{: .tip}

The level
=========

Your monkey moves around in a flat 2D level. You can think of the level as
a matrix, where any square can be occupied by one thing at any given time.

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

Every monkey is represented in the level by a numerical id:

* *Monkey*: `\d`

Besides monkeys, the level can also contain:

* *Tracks*: `spotify:track:......................`
* *Walls*: `#`
* *The User*: `U`

Your monkey has one mission: to find and deliver suitable track 
recommendations to *The User*.

Glossary
========

Level units
-----------

Monkey `M#\d+`
: Description of a monkey and stuffs.

User
: Deliver your tracks to the User to score points!

Wall
: An obstacle. Represented by the ASCII character `#`.
