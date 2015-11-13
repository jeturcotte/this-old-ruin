# This Old Ruin
An attempt at creating a new generation of text-based adventure/exploration game.  If you have ever played a MUD game before, you'll probably have an immediate sense of how to proceed with this one.  There are some differences intended, but they are to be discovered rather than simply revealed up front.

## backstory
There is none.  Well... none I can write about, anyways.

Your character awakes in underground depths of an ancient ruin.  You've no idea who you are.  You've no idea where you are.  You've no idea why you are there.  Consciousness had come slowly until you heard that sound, to which you sat bolt upright in a strange place, in a strangely shaped and softly lined depression surrounded by angular broken stones speckled with small and mildly luminescent plants... perhaps a moss of some sort.  But you can't focus on that; not when that droning grunt could have come from just around the corner.

## goals
I personally have a few goals in beginning this project.
* Get back into programming for personal growth, personal entertainment, et cetera.  Doing software development at the day job has robbed the fun from something I began doing when I was six years old... and I think I'd be better off if I could enjoy doing this again.
* LEARN Rakudo/Perl6
* Give others looking to try Rakudo/Perl6 something to look at
* Make another game... the last one I made and completed was back in '93 or '94. (see: http://www.aderack.com/game-maker/index.php?title=Orb:_The_Derelict_Planet)
* In fact... make the FIRST game in a universe I've been poking at, conceptually, SINCE releasing the last.
* Populate github with something of note.  It has been... anemic.

## gameplay
In this section the basic methods of play are described.
### movement
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

### examination
* A critical part of interactive with the game invovles examining your surroudings and/or objects within it.
  * `look`
  * `touch` or `feel`
  * `smell` or `sniff`
  * `listen`
  * `taste` or `lick`
  
### manipulation
* Manipulating objects is core to operating the world in which your character finds itself.
  * `weigh`
  * `push` or `shove`
  * `pull`
  * `turn` or `rotate` or `twist`
  * `lift` or `heft`
  * `grasp` or `grab`
  * `release`
  * `fit` or `attach` or `splice` or `combine`
  * `unfit` or `disattach` or `split` 
  * `place` or `insert`
  * `remove` or `extract`
  * `stack` or `lay`
  * `unstack` or `unlay`
  * `assemble` or `build` or `construct`
  * `disassemble` or `unbuild` or `deconstruct`
  * `carve` or `etch`
  * `polish` or `smooth`
  * `insert`
  * `extract`
  

### conflict
* This is a harsh world you find yourself in, and you may well end up prey.  Best adjust.
  * `aim` 
  * `bl` or `block`
  * `sl` or `slash`
  * `bl` or `bludgeon`
  * `st` or `stab`
  * `pa` or `parry`
  * `sh` or `shoot`
  * `do` or `dodge`
  * `du` or `duck`
  * `fl` or `flee`
  * `h` or `hide`

## development
In this section I will attempt to lay out the major milestones necessary to achieve a complete product

### event looping
Starting a game involves creating a persistent engine that engages in looping through tics
* Each tic involves a number of checks and emits events to any reading interface
  * Some events may be pre-indexed to future tics at the point of their creation
  * Others may culminate based on evolving events initiated in the past
  * Others still may be based on random chance

### game interface
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
 
### character maintenance
### world generation
### plot generation
