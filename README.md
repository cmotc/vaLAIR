LAIR!
=====

LAIR! is a rogue-like dungeon crawling game that draws it's influences primarily
from the classic 2D Legend of Zelda games(Gameplay), Teleglitch: Die More
Edition(Aesthetically), Borderlands(Mechanically), and MMORPG's. It's been
something I've been developing for a long time, and I'll probably never consider
it truly done, but it's abou time I start documenting how to actually play it
now that I'm going to have a version in a week or two.

Installation
------------

It's getting there. I keep fiddling about with it and it's a little
transitional. That said, somebody with all the dependencies can build it on
Linux and probably other unixes and start playing with it for now. It's just
a makefile now, just running "Make" in the working directory will build the
executable in the ./bin/ directory. Then there's art and the configuration files
to install, which are in the [art repository](https://github.com/cmotc/lairart),
which you can install with make; sudo make install.

Configuration(You probably don't need to read this unless you want to mod)
--------------------------------------------------------------------------

Configuration is done with plain text files and a shell-script based launcher
for the actual binary /usr/bin/LAIR. You can hypothetically use the launcher
to combine multiple configuration files together and expand the content of the
game. Examples forthcoming, but if you've ever used sources.list.d you know
what I'm about.

As far as the actual configuration files go, it's pretty simple. Here's an
example line.

        "Path to a file containing a resource"    "Name"    "List of tags"
        /usr/share/lair/stonewall/stonewall-1.png stonewall wall stone

The first part is obviously a path to a png file. Followed by a space, the first
word following the path is the name of the file. The name is also the first tag
that can be used to produce a random tile from a specific category with the game
engine, or it can be used to retrieve a specific tile with the game engine. So
the first tag, the name, should be unique, and the remaining tags could be
non-unique. For more example configuration files, see the [art repository](https://github.com/cmotc/lairart).

How it works
------------

The game considers every piece of content to be the same type of in-game object.
They all have exactly the same attributes and all the same things can happen to
each of them. The only difference between the player and the other entities is
that the player's movement is controlled by a person and not by a scripted
routine. Inside the entities, there are scripts that control what actions the
entity takes depending on feedback from it's environment. That's mostly the
unfinished part, that and networking, and I need to create some new/better
template art, then it's going to be done. Yay.

God, I'm really trying to get a handle on planning all this stuff.
------------------------------------------------------------------

I've been making some unsatisfying version or other of this for so long that
it's hard to keep ahold of what my goals are. Things I'm pretty sure I have left
to do:

  * Finish Room and Floor specific conditions, which are basically transitions
  and Fog of War. Be done by midnight December 20.
  * Rename existing DigitalAndy configuration files and reform /usr/lair and
  index development process to follow. Be done by 4P December 20.
  * Add a few features to digitalAndy: Trianges. Adjustable Sizes. Final images
  Trimmed to minimum rectangular sizes so I can eliminate the static hitboxes.
    - Port digitalAndy to Android with a simple pixel-painting interface capable
    of outputting a configuration file for PC digitalAndy as well as a script.
    Do it to learn Android app development in Go.
  * Add scripting to map generation for modifying maps after the construction of
  the map objects. I think for now I'll keep the generation of walls and basic
  structures something that is statically configured though because otherwise
  I think we might get some unpredictable behavior with the size of the maps.
  * Add scripting to the resource management interface to demonstrate procedural
  content generation based on tagging
    - Possible idea? Generate lists of the most common tags in a person's
    avaialable resources and compare them against some kind of dictionary to
    generate new "dungeon seeds?" Also that's what I'm calling the tag lists
    that are used to generate the dungeons right now, and it's what the scripts
    will be called.
  * Configuration with Environment Variables as well as Flags and Files
  * Implement AI class, which is similar to the move class but instead of doing
  actions on events it does actions based on the execution of Lua scripts
  * Write some example AI scripts
  * Networked play support, with sub-tasks
    - Game Server as Group Chat?
    - This will become clearer as I do it, I think...
  * Low GUI Mode for running a game without a player, in order to behave like a
    server.
  * I'm sure that there's more but I'll have to come to that.
