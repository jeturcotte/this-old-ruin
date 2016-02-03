# This Old Ruin
An attempt at creating a new generation of text-based adventure/exploration game.  If you have ever played a MUD game before, you'll probably have an immediate sense of how to proceed with this one.  There are some differences intended, but they are to be discovered rather than simply revealed up front.

# backstory
There is none.  Well... none I can write about, anyways.

Your character awakes in underground depths of an ancient ruin.  You've no idea who you are.  You've no idea where you are.  You've no idea why you are there.  Consciousness had come slowly until you heard that sound, to which you sat bolt upright in a strange place, in a strangely shaped and softly lined depression surrounded by angular broken stones speckled with small and mildly luminescent plants... perhaps a moss of some sort.  But you can't focus on that; not when that droning grunt could have come from just around the corner.

# goals
I personally have a few goals in beginning this project.
* Get back into programming for personal growth, personal entertainment, et cetera.  Doing software development at the day job has robbed the fun from something I began doing when I was six years old... and I think I'd be better off if I could enjoy doing this again.
* LEARN Rakudo/Perl6
* Give others looking to try Rakudo/Perl6 something to look at
* Make another game... the last one I made and completed was back in '93 or '94. (see: http://www.aderack.com/game-maker/index.php?title=Orb:_The_Derelict_Planet)
* In fact... make the FIRST game in a universe I've been poking at, conceptually, SINCE releasing the last.
* Populate github with something of note.  It has been... anemic.

# gameplay
In this section the basic methods of play are described.

## meta
* Seeing as how you do not actually EXIST in this nonexistant world, there are things you can do that you normally would not be able to...
  * `q` or `quit`
  * `debug`
  * `gameplay`

## character maintenance
* Playing a being in this alternate universe may, from time to time, require checking on themselves...
  * `check`
  * `hunger`
  * `thirst`
  * `fatigue`
  * `wounds` or `injuries`
  * `inventory`
  * `equipment`
  * `talents` or `skills`

## movement
* Movement commands made available will be very similar to those of MUD games. Each of these assume that a path in that direction has been made available within the room that the player currently is in.
  * `u` or `up` 
  * `d` or `down`
  * `n` or `north`
  * `ne` or `northeast`
  * `e` or `east`
  * `se` or `southeast`
  * `s` or `south`
  * `sw` or `southwest`
  * `w` or `west`
  * `nw` or `northwest`
  * `i` or `in` or `en` or `enter`
  * `o` or `out` or `ex` or `exit`
* More, sometimes you may need to move in these directions in various ways
  * `walk` (when not specified)
  * `step`
  * `run`
  * `crawl`
  * `leap`

## examination
* A critical part of interactive with the game involves examining your surroudings and/or objects within it.
  * `examine` or `study`
  * `look`
  * `touch` or `feel`
  * `weigh`
  * `smell` or `sniff`
  * `listen`
  * `taste` or `lick`
  
## manipulation
* Manipulating objects is core to operating the world in which your character finds itself.
  * `push` or `shove`
  * `pull`
  * `turn` or `rotate` or `twist`
  * `lift` or `heft`
  * `grasp` or `grab`
  * `release` or `give`
  * `fit` or `attach` or `splice` or `combine`
  * `unfit` or `disattach` or `split` 
  * `place` or `insert`
  * `remove` or `extract`
  * `stack` or `lay`
  * `unstack` or `unlay`
  * `assemble` or `build` or `construct`
  * `disassemble` or `unbuild` or `deconstruct`
  * `carve` or `etch`
  * `polish` or `smooth` or `sand`
  * `insert`
  * `extract`
  * `write` or `scribe`
  * `erase` or `redact`
  * `fiddle` or `tinker` or `experiment`
  * `scrape`

## interaction
* Believe it or not, there are other beings in this world you find yourself in, and not all interactions with them must necessarily be violent...
  * (vocal)
    * `tell` or `say` or `express`
    * `ask` or `inquire` or `request`
    * `command` or `order` or `demand`
    * `ignore`
    * `whisper` or `mutter`
    * `yell` or `proclaim` or `scream`
    * `listen`
    * `teach`
  * (physical)
    * `comfort` or `console`
    * `gesture` or `sign` or `emote`
    * `dance`
    * `hug` or `embrace`
    * `bow`
    * `restrain` or `tackle`
    * `exchage` or `trade`

## conflict
* This is a harsh world you find yourself in, and you may well end up prey.  Best adjust.
  * defense...
    * `bl` or `block`
    * `pa` or `parry`
    * `do` or `dodge` (`do` is questionable)
    * `da` or `dash`
    * `du` or `duck`
    * `fl` or `flee`
    * `h` or `hide`
    * `ro` or `roll`
  * offense...
    * `aim`
    * `sl` or `slash`
    * `bl` or `bludgeon`
    * `st` or `stab`
    * `sh` or `shoot`
    * `ba` or `bash`
    * `gr` or `grapple`
    * `tr` or `trip`
    * `t` or `toss` or `throw`
    * `k` or `kick`
    * `tr` or `trip`

# development
In this section I will attempt to lay out the major milestones necessary to achieve a complete product

## event looping
Starting a game involves creating a persistent engine that engages in looping through tics
* Each tic involves a number of checks and emits events to any reading interface
  * Some events may be pre-indexed to future tics at the point of their creation
  * Others may culminate based on evolving events initiated in the past
  * Others still may be based on random chance

## game interface
Following the production of at event emitting engine, there will have to be an interface which can read those emissions and submit events back to said engine as well.
* The interface initializes the engine
  * If a saved game is sent along with the initialization script, it will be loaded
  * Otherwise, a new game will be generated at random
* Once loaded, a description will be set to the interface from the engine of the player's current location
* The engine will also report and registered events that have come to pass as tics pass
* The interface will allow the player to report events back to the engine, which will react accordingly
  * The player can MOVE along available paths from one ROOM to the next
  * The player can EXAMINE the ROOM itself as well as any OBJECTs present
  * The player can MANIPULATE the ROOM and/or any OBJECTs present, as well as their self 
  * The player can engage in CONFLICT with animate OBJECTs or CREATUREs that may be present
  * The player can DISENGAGE from the game through a variety of means
    * A player that seeks shelter will return to the game later in better condition than they were, with very little change of a negative random event being assigned to their return
    * A player that simply quits will return to the game later in equal condition, but with a high chance of having to endure a negative random event upon return
    * A player that breaks the connection without manually quitting is guaranteed a harsh negative random event upon return
 
## content generation
Having an engine to which the player's client can talk is not quite enough for a good game.  There must be content, and that content will be generated anew with each new game.  In other words, we will have some amount of procedural rendering, as expressed in text.
* Every game starts in a ruin, no matter what.
  * This ruin can be largely indoors or outdoors, or an even blend of both
  * This ruin can be made from a variety of materials, and not necessarily those common to the region surrounding said ruin
  * This ruin will be in a variably chosen and mostly (if not completely) consistent condition
    * Merely Deserted
    * Intact, but Scarred
    * Notably Damaged
    * Severely Damaged
    * Essentially Destroyed
    * A Wreckage of Overgrown Debris
  * The ruin will vary in overall dimension
* Beyond the extremities of this ruin will lay a variety of `biomes` 
  * `biomes` are defined, in part, by a list of component `resources` which guide the characteristics on that area as well as a few other things.
    * The list of resources begin with the `lithosphere` and the `hydrosphere`.
    * Between those two, a `biosphere` can be determined, from which `creatures` will populate the vicinity.
    * `Creatures` are either `sessile` or `mobile`... they either occupy one location for life (like a bush or a tree) or move about.
      * `Sessile creatures` may, in fact, impose barriers to passage on the world map. 
    * Combinations of `biospheres`, `hydrospheres`, and `lithospheres` will determine the likelihood, as well, of `settlements`, if any.
    * Of course, any `settlement` may well have become a `ruin` and we return to where we began.

## object generation
It's not just that there needs to be places where you can go, in game, but there must also be objects with which you can interact.  I kinda hate to suggest that this may be an 'object-oriented' game, to pun a bit, but ... well ...
* Items, in game, need to be contextually coherent
  * If a `biome` comes, say, from a region rife with flint or quartz, appropriate objects crafted or grown by anything that might have been native, would probably reflect this.  This also offers as a clue, should one ever need such a thing!

## creature generation
So, odds are you won't be alone in this world you find yourself in.  Hell, if it were a lifeless place, you'd not be able to breathe and would die immediately... and that's no fun!
* Creatures that habit one or more `biomes` are naturally shaped by them.

## plot generation
Given an engine, an interface, and a world full of things and places, the game also needs something to prod the player... to him them motivation to keep playing.  As an avid fan of builder and exploration games, I still find that there comes a point of exhaustion... a point where 'what's the point' is asked.  Generating plotful and meaningful events (e.g., something other than completely random) is necessary to keep the game going.
* As part of the generation of a world in which to play, the game will also set and play through a few different alternative endeavors that are likely to run contrary to the player's own intentions
  * This means the development of some basic AI
    * The nature of each generated AI can vary widely
    * Each AI needn't be particularly complicated so long as they can pursue their own interests

# TODO
Here be dragons...!

### `v0.1.*` BASIC GAME ENGINE
* ~~Establish a tic-loop daemon~~
  * ~~this engine separates as a process upon instantiation~~
    * ~~Internally, one threaded process listens for player input from the socket~~
      * Commands found are sent to a buffer
    * ~~Separately, it loops through interpretation and rendering commands~~
      * Commands found in the buffer are interpreted, rejected or accepted, and rewarded
      * Processes that influence the movement and behavior of `creatures` (to be implemented later) are calculated
      * Processes that influence the game climate (to be implemented later) are then calculated
  * this engine responds to shutdown commands
  * provide a debug mode that reports out the engine's activities

### `v0.2.*` A NOT SO FLAT WORLD
* Derive an algorithm for the rendering of plausible `mineral resources` populate the world
  * Determine characteristics of each `mineral resource`
* Build rendering algorithm that renders a variable but plausible `lithosphere`
  * Splay wide swaths of `mineral resources` in overlapping regions
  * Determine hardness of a region's surface and erode accordingly
  * Render veins of concentrated `mineral resources` that may be exposed on the surface
* Utilize resulting topography to render correct impasses to travel

### `v0.3.*` A NOT SO DRY WORLD
* Derive a `hydrosphere` altitude that will overlay the `lithosphere`
* Carve `hydrosphere` paths into the `lithosphere`
  * Check prevalence of `mineral resources` to influence water pathing and pooling
  * Check on characteristics of local `mineral resources` to influence characteristics of the `pool` or `stream`
* Update game engine and client to react accordingly to attempts to travel into the `hydrosphere`
  * Report when character is wading or not
  * Report when character is forced to swim
  * Report when character is completely submerged
  * Check character's lung capacity and report if struggling

### `v0.4.*` A NOT SO DEAD WORLD  
* Build an algorithm that renders a `biosphere`
  * Consider altitude to the `hydrosphere`
  * Consider characteristics of the `lithosphere` and local `resources`
  * Consider characteristics of the `atmosphere`
  * Calculate thresholds that identify `biomes` from all these variations 
* Build an algorithm for the population of these areas with plausible `creatures`
  * Procedurually generate a cadre of `creature plans` for the entire world
    * Based on their designs, assign a `creature plan` to a set of applicable biomes
  * For each individual `biome` assign a subselection of appropriate `creature plans` and add on local variations
  * Develop system for measuring the physical and intellectual characteristics of these `creatures`
  * Develop system for rendering interaction types available to each `creature` and apply a spectrum of individualization
    * Is the creature skittish, obtuse, curious, aggressive?
    * How does the creature defend itself or hunt other creatures?

### `v0.5.*` A NOT SO SAFE WORLD
* Build an algorithm for the intelligent animation of `creatures` in the world

### `v0.6.*` A NOT SO POOR WORLD 
* Build an algorithm for the population of `objects` that originating from `resources`
* Build an algorith mfor the population of `objects` on or left by `creatures`

### `v0.7.*` A NOT SO UNINHABITED WORLD
* Build an algorithm for the creation of `ruins` and `communities` in the world
  * Develop a mechanism for determining where a construct is more likely to have been built
  * Develop a mechanism for deciding on a plausible layout for the construct
  * Develop a mechanism for determing what condition the construct is in
    * Develop a mechanism for decaying the structure in plausible ways
  * Develop a mechanism for populating the ruin with `creatures` 

### `v0.8.*` NOT SO RANDOM WORLD
* Build an algorithm for the establishment of `goals` and `quests` in the world

# ALTERNATIVELY
Looks like I'm not the only one!
* https://github.com/masak/Adventure-Engine

# THANKS
* Thanks to `lizmat` of the perl6 channel on freenode, directly me to look at Supply and Supply.throttle after my complaining about IO::Socket::Async's not talking easily to telnet clients.
* Similarly, `RabidGroovy` may be looking into why aforementioned IO::Socket::Async may not be behaving as expected in that circumstance.
