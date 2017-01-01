LAIR's Lua-Based Configuration for Level Generation
===================================================

LAIR is scriptable in several ways in order to facilitate it's ability to do
Procedural Content Generation.

Terminology:
------------

  * Map: Map represents the whole 2D surface which will be generated bit by
  bit during the map generation procedure. In the Vala code, it corresponds to
  a Floor. Maps consist of Rooms, which in turn contain "Entities" known as
  "Particles" and "Mobiles."

  * Floor: Floor is a synonym for Map as Map is used in this document. In the
  Vala code, a Map is always referred to as a Floor, and a stack of Maps is
  always referred to as a Tower. Each is basically a layer of syntactic sugar
  for manipulating the smaller data structure.

  * Room: Rooms are organized units of Particles and Mobiles. Each room has
  retrievable properties and has

  * Entity: Entity is an organized unit of data(it's a type) that corresponds to
  the minimum interactable unit of content. A single floor tile is a single
  Entity, as is a single wall, as is a single monster and the player itself. All
  the direct interaction in the game is done strictly on an entity->entity
  basis.

  * Particle: A particle is an entity which never has any effect on another
  entity UNLESS that effect is to trigger a non-damaging collision. In essence,
  an otherwise benign wall is always a particle. It's still the same kind of
  entity, but since these types of entities will be A) Commonplace, and
  B) Guaranteed to never do *most* of the things other entities will sometimes
  do, it makes sense to skip alot of steps when they take their turns.

  * Mobile: A mobile is an entity which is interactive in some way or another.
  It might be damaging to the player if it is touched, it might be possible to
  add to your player's inventory, it might be able to converse eventually.


Map Configuration:
------------------

###Lua Functions Informing Decisions Made in Vala during Map Generation

Dynamic Map Configuration works by populating a group of variables which can
be used to determine if an entity should be placed on the map and if so, what
type. You can script this behavior by retrieving information from the map in
Lua and using it to decide what values those variables have at any given moment.
This is done by defining functions that return the desired values. Those
functions are:

####Selecting Particle Entities

  * map\_cares\_insert() : \[ Returns: bool \] This determines whether the map
  is going to bother to insert a Particle in this square whatsoever. If the
  value is false, then none of the other selection functions will be run for
  that Particle.
  * map\_image\_decide() : \[ Returns: Array of Strings \] This determines what
  attributes the image selected for the new particle should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random image with all the tags will be
  retrieved.
  * map\_sound\_decide() : \[ Returns: Array of Strings \] This determines what
  attributes the sound selected for the new particle should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random sound with all the tags will be
  retrieved.
  * map\_fonts\_decide() : \[ Returns: Array of Strings \] This determines what
  attributes the font selected for the new particle should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random font with all the tags will be
  retrieved.

####Selecting Mobile Entities

  * mob\_cares\_insert() : \[ Returns: bool \] This determines whether the map
  is going to bother to insert a Mobile in this square whatsoever. If the value
  is false, then none of the other selection functions will be run for that
  Mobile.
  * mob\_image\_decide() : \[ Returns: Array of Strings \] This determines what
  attributes the image selected for the new mobile should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random image with all the tags will be
  retrieved.
  * mob\_sound\_decide() : \[ Returns: Array of Strings \] This determines what
  attributes the image selected for the new mobile should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random image with all the tags will be
  retrieved.
  * mob\_fonts\_decide() : \[ Returns: Array of Strings \] This determines what
  attributes the image selected for the new mobile should have. It returns an
  array of strings which corresponds to a set of tags. The tags will be checked
  against the game resources and a random image with all the tags will be
  retrieved.

###Vala Functions registered with Lua for Map Generation


Besides that, you need to be able to retrieve different types of information
from the map. The same information you can pass to the map generator can be
retrieved from the

  * particle\_count :
  * particle\_index\_byxy :
  * particle\_count\_bytag :
  * mobile\_count :
  * mobile\_index\_byxy :
  * mobile\_count\_bytag :

###Lua Functions wrapped in Vala Functions for Ease of Use and Sanity Checking

Last but not least, when Vala needs to get information out of the Lua VM then
in order to make the results more predictable and debuggable, sanity checking
is to be done in both Lua(Via the lair/common.lua file) or in Vala functions
specifically used for retrieving that information as needed. Many of these
functions pass information back and forth from Vala to Lua to use as parameters.
Mostly this amounts to managing strings, but it should be done as safely as
possible.

Current Limitations
-------------------

Obviously, the programming interface isn't really present yet.

Because the map generator currently works from left to right, then from top to
bottom, and because by definition all the information that the map can recieve
has to come from entities that the map has already initialized, there is bias
inherent in how the maps are generated. This can be solved, but it might not get
solved for a little while because I want a prototype and that issue is fairly
isolated.

I still haven't done the Lua configuration for AI controlled entities.

I still haven't decided whether I'll be using Lua to script how player
characters are generated.
