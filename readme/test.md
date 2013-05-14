<img class="logo" src="documents/logo.png" />

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
