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
  * `turn` or `rotate`
  * `lift` or `heft`
  * `grasp` or `grab`
  * `release`


## development
In this section I will attempt to lay out the major milestones necessary to achieve a complete product.
### basic interfacing
* In order to separate user input from a tic based event engine, I will been to build a tic based event engine and, presumably, a means of connecting to it.  A socket, perhaps.
* The interface itself will provide a prompt that the player is expected to use to input commands.

### event looping
### character maintenance
### world generation
### plot generation
