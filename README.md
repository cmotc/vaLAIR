LAIR!
=====

LAIR! is a rogue-like dungeon crawling game that draws it's influences primarily
from the classic 2D Legend of Zelda games(Gameplay), Teleglitch: Die More
Edition(Aesthetically), Borderlands(Mechanically), and MMORPG's. It's been
something I've been developing for a long time, and I'll probably never consider
it truly done, but it's about time I start documenting how to actually play it
now that I'm going to have a version in a week or four. Also it's capitalized
for now because it used to be an abbreviation. That might change because it's
not anymore.

Installation
------------

###Debian/Ubuntu:

Now it's possible to build a .deb package and if you want, install it
automatically. To build the .deb package(but not install), do

        make deb-pkg

and then do

        sudo dpkg -i ../lair*.deb

###Other Linux:

It's just a makefile now, just running "make" in the working directory will
build the executable in the ./bin/ directory. After that, running "sudo make
install" will install the executable and the configuration files, or if you'd
prefer not to install that way, you can specify the paths to the configuration
files via the command-line flags for now:

        ----------------------------
             -i : display this info
             -l : log to files instead of stdout
             -p : path to the image file listing
             -s : path to the sound file listing
             -f : path to the fonts file listing
             -m : map size(tiny, small, medium, large, giant
             -c : path to map generation script
             -e : path to character generation script
             -a : path to ai library script
             -v : log output verbosity
             -w : screen width
             -h : screen height

which are in the [art repository](https://github.com/cmotc/lairart), which you
can install with make; sudo make install.

###Windows:

Very untested, like literally zero testing at all, but technically it has been
successfully cross-compiled for Windows 32 and 64 bit using M Cross Environment.
For now, test at your own risk.

###OSX, iOS, and Android coming soon.

Configuration(You probably don't need to read this unless you want to mod)
--------------------------------------------------------------------------

###Static Configuration

Static Configuration done with plain text files and a shell-script based
launcher for the actual binary /usr/bin/LAIR on Unix, or a Lua based config file
on Windows. You can hypothetically use either launcher to combine multiple
configuration files together and expand the content of the game. Examples
forthcoming, but if you've ever used sources.list.d you know what I'm about.

As far as the actual configuration files go, it's pretty simple. Here's an
example line.

        "Path to a file containing a resource"    "Name"    "List of tags"
        /usr/share/lair/wall_stone_bricked/wall_stone_bricked-4.png wall stone bricked default

The first part is obviously a path to a png file. Followed by a space, the first
word following the path is the name of the file. The name is also the first tag
that can be used to produce a random tile from a specific category with the game
engine, or it can be used to retrieve a specific tile with the game engine. So
the first tag, the name, should be unique for things you want to refer to
specifically, and the remaining tags could be non-unique. For more example
configuration files, see the [art repository](https://github.com/cmotc/lairart).

###Dynamic(Lua) Configuration

Dynamic configuration is only enabled for the Maps at this time.

Dynamic Map configuration is done by using Lua to define what actions the game
takes to generate effects in a particular set of circumstances. The maps inform
the Lua virtual machine of what the state of the map is while the map is being
generated, and this information can be used to control how the generation
proceeds. They're fully functioning Lua scripts and can do everything Lua can
do, but they are only run once when the game is initialized. The interface is
a work in progress right now. Please see [LUA.md](https://github.com/cmotc/vaLAIR/blob/master/LUA.md)
as it changes.

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

  1. Implement AI class, which is similar to the move class but instead of doing
  actions on events it does actions based on the execution of Lua scripts
   1. Now the AI's can see but it's not clear what the best way to use their
   senses are. Basically the mob gets a table containing all the nearby mobs
   and blocked particles and you can use that to make decisions.
  2. Write some example AI scripts.
   1. AI Common Lua Requirement is share/lair/lua/ai/common.lua
  3. Networked play support, with sub-tasks
   1. Game Server as Group Chat?
   2. This will become clearer as I do it, I think...
  4. Make More Art! digitalAndy is making this alot easier.
  5. Add a few features to digitalAndy: Triangles. Adjustable Sizes. Final images
  Trimmed to minimum rectangular sizes so I can eliminate the static hitboxes.
   1. Can work-around many shortcomings of digitalAndy with imageMagick. Maybe
   it should become part of a toolchain for procedural pixel art.
   2. Port digitalAndy to Android with a simple pixel-painting interface capable
   of outputting a configuration file for PC digitalAndy as well as a script.
   Do it to learn Android app development in Go.
  6. Low GUI Mode for running a game without a player, in order to behave like a
    server.
