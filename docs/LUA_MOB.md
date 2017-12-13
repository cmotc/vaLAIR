LAIR's Lua-Based Configuration for Programmable Mob Behavior
============================================================

How to get Environmental Information from the Mob's Point of View in Lua
------------------------------------------------------------------------

Every time an event occurs, the mob checks a nearby area for things it needs to
be aware of, and it "notices" some details about them by putting them into a
long list of strings and then making those strings accessible in the "vision"
global lua table. Each mob has it's own vision table and the vision table
changes periodically based on the Mob's surroundings.

To see a full listing of the vision table, place the print\_seen\_details()
function in your ai function in your ai.lua file. Running

        print_seen_details()

from lua will produce output resembling:

        Printing details about nearby entities:
        ---------------------------------------
          * particle  x:64 y:320 w:32 h:32 skills: speed  exert  dodge  aim  will  resist  magic  tech  tags:blocked wall stone particle  was found at key: 29
          * mobile  x:160 y:224 w:32 h:32 skills: speed  exert  dodge  aim  will  resist  magic  tech  tags:blocked med mobile  was found at key: 1
          * mobile  x:96 y:288 w:32 h:32 skills: speed  exert  dodge  aim  will  resist  magic  tech  tags:blocked med mobile  was found at key: 0

but much longer. This is the *Whole* vision table and it's printing the whole
thing, so don't use this in production. It's for testing only. In production,
use the functions I'll be documenting over the next couple days.

How to get Information about a Mob from the Mob's Point of View in Lua
----------------------------------------------------------------------

A mob also needs to have information about itself to make decisions. It gets
a summary of this in it's self table, and details can be found in the self_*
tables corresponding to your stats.

To see a full listing of the self table and self_* tables, place the
print\_self\_details() function in your ai function in your ai.lua file. Running

        print_self_details()

from lua will produce output resembling:

        Printing details about self:
        ----------------------------
          * mobile  x:224 y:64 w:32 h:32 skills: speed  exert  dodge  aim  will  resist  magic  tech  tags:blocked med mobile  was found at key: self
          * 4 was found at key: speed

It's pretty much safe, but not very useful to view the whole self table in
production scripts. This is mostly for testing and better functions will be
written and documented soon.

How to Write functions to help your Mob's make Decisions
--------------------------------------------------------

TBC.

What are AI functions
---------------------

Unlike Map functions, AI functions are not pre-defined. The dungeon designer
defines AI functions of his own in the ai.lua(or other lua file as directed) on
his or her own and decides the function that each Mobile will use at the

How AI Functions are decided per-Mobile
---------------------------------------

They are set at runtime, during the Mob Placement phase of Map Generation, by
the mob\_ai\_decide() function.

AI Function Helpers: Environment Information Gathering
------------------------------------------------------

TBD.

AI Function Hooks: Making Mobs take Actions
-------------------------------------------

Will correspond to the move functions for players, mostly.

AI Examples
-----------

TBD.

LAIR AI Library
---------------

TBD.
