Overview
Impossible Mission ?
Title
	Options
		Difficulty
			Difficulty alters the amount of time given to complete the game
			The option displays by default EASY.
			Pressing SPACE will select between EASY, HARD and IMPOSSIBLE
			EASY       - The game must be completed in 6 hours
			HARD       - The game must be completed in 4 hours
			IMPOSSIBLE - The game must be completed in 2 hours
		Screen Mode
			Screen Mode alters sets the screen Colour
			The option displays by default Colour
			Pressing SPACE will select between COLOUR and MONOCHROME
			The Screen mode may also be changed again within the game
		Audio
			Audio control is limited to On or Off
			Pressing SPACE will toggle between AUDIO ON and AUDIO OFF
		Load Game
			Load Game assumes a game has already been saved to Tape.
			If Load game is used when no save game was used then the game will crash!
Game
	Overview
		
	Corridors
		Corridors and Lifts provide a method of accessing the rooms of the complex.
		On game start the hero will be seen in the Lift cage.
		Pressing UP or DOWN will move the lift to the next room access level.
		Pressing LEFT or RIGHT when the lift arrives at a Room access level allows the hero
		to run into the corridor. Attempting to run off-screen will move the hero into the
		adjacent room
		Pressing SPACE whilst LEFT or RIGHT is held down will allow Ethan to somersault in the
		corridor. In this way the Hero can somersault into the room.
	Rooms
		Moving Around
			Ethan can run with the LEFT or RIGHT keys. Ethan will somersault when Pressing SPACE.
			within each room may be a number of foot-lifts that allow Ethan to ascend or descend
			to another level. Some may be linked to others lifts higher up.
			The lifts may be operated by simply stepping onto them and pressing UP or DOWN respecively.
		Searching
			Within each room may be found Furniture. These must be searched to find puzzle pieces
			or bonus cards.
			To search a piece of furniture step infront of it and press and hold UP.
			A little Searching window will show your progression. Was the progression has ended
			the window will be replaced by the item you found. Releasing the UP key will return
			Ethan to the standing state.
		Security Terminal
			You may also notice security terminal within each room. These computers may be accessed
			at any time and hold a menu to allow you to use your passcodes found.
				Reset Lifting Platforms
					If you possess lift-reset passes then selecting this option will
					Reset all lifts in this room to their default positions.
				Disable Robots
					If you possess snoozes then selecting this option will freeze the
					robots for about 30 seconds allowing you to safely pass them without
					you being electricuted.
					Using multiple Snoozes is possible, accumulating the snooze time.
		Simon Computer
			One room within the complex contains a very large computer and an even larger screen called
			the Simon Computer. This is a device capable of incredible power but which has been demotivated
			to emulate the game of Simon. The rewards are free pass codes.
			Ethan must first step up to the concole and press UP to operate it.
			
			Simon will play a series of notes on the chequerboard. each cell representing a separate note.
			No note will be played the same.
			
			Ethan must then replay the sequence but always in ascending order, that is starting with the
			lowest note in the scale and ending with the highest.
			
			Once the notes have been played, ethan can move around the chequerboard with the LEFT,RIGHT,UP
			and DOWN keys. Press SPACE will select the square as the next note in the sequence.
			This will be heard and if correct the computer will allow the next note to be selected.
			Once all notes are played, the chequerboard will flash and a random pass-code will be awarded.
			
			However if the selection was not correct then ethan will be	logged off.
			
			After each successful attempt the number of notes in the sequence will increment making the game
			more challenging. 
		Control Room
			Within the complex is a room that contains the doorway to Elvins control room.
			This door is locked and only accessable once the passcode is found.
			If the passcode is found then walk up to the door and press UP.
	Scorepanel
	Pocket Computer
		Ethan posesses a neat little console on his wrist that can be accessed only in the corridors.
		The pocket computer is used to monitor the remaining time, manipulate the puzzle pieces, and
		various other functions.
			Power Button
				The power button allows the pocket computer to be switched on or off.
				Whilst the pocket computer is being used the action in the corridor freezes.
				However the time will still elapse.				
			Disk Button
				Presents a menu where various in game options are presented.
					Save Game
						Saves the current game to tape
						If an emulator is being used then only one game may
						be saved to tape.
					Load Game
						Loads a previously saved game. All current game elements
						will be loaded from that previous session
					Quit to Title
						Quits the current game and returns the game to the title
						screen
						WARNING!: There is no confirmation to quit after this option is selected
					Screen Mode
						Sets the screen mode beteween monochrome and Colour.
			Modem Button
				The modem offers a number of useful in-game options.
				If sound is enabled then a dialling tone will be constantly sounded during this menu. 
					Enough Pieces for Punchcard
						The pocket computer will dial out to the mainframe and transmit
						the current puzzle pieces to it. The mainframe will report back
						if a punchcard can be formed from these pieces collected.
						
						Note that this option will only search the list on the left.
						Any puzzle pieces half merged in the right work window will not
						be counted.
						
						This option will take 2 minutes off your time.
					Locate Simon and Ctrl Room
						Within Elvins complex lie two special rooms, the control room
						and the Simon computer room
						This option will locate the rooms and display them in the complex
						map when the pocket computer is switched off.
						
						This option will take 2 minutes off your time.
			Puzzle Editor
				Old Mr Elvin Atombender decided in his wisdom to hold each letter of the passcode in 7
				punchcards. Not only this but he also decided to smash and discolour all the
				punchcards into puzzle pieces which lie in random furniture all over the complex.
				???Each punchcard requires 4 puzzle pieces to form it. Each puzzle piece may be mirrored, flipped
				
				In fact there are a total of 28 puzzle pieces,
			Controls
			Flip Button
			Mirror Button
			Undo Button
			Yellow Button
			Green Button
			White Button
		Speaker Button
		Statistics Button
		Pause Button
Credits
All code, graphics and sound was written and composed by Twilighte
Additional help was provided by Chema, Symoon, Dbug, ?


;Image map of scorepanel
<img src="pics\scorepanel.gif" alt="alternative text" usemap="#scorepanel" />
<map name="scorepanel">
  <area shape="rect" coords="12,6,41,33" href="buttonpower.htm" alt="Power button" />
  <area shape="rect" coords="12,34,41,63" href="buttondisk.htm" alt="Disk button" />
  <area shape="rect" coords="12,64,41,95" href="buttonmodem.htm" alt="Modem button" />
  <area shape="rect" coords="48,6,133,95" href="puzzlememory.htm" alt="Puzzle Memory Window" />
  <area shape="rect" coords="134,6,231,95" href="puzzlework.htm" alt="Work Memory Window" />
  
  <area shape="rect" coords="240,6,288,21" href="ScoreAudio.htm" alt="Audio" />
  <area shape="rect" coords="300,6,351,21" href="ScoreDifficulty.htm" alt="Difficulty"/>
  <area shape="rect" coords="240,24,351,39" href="ScoreScore.htm" alt="Score" />
  <area shape="rect" coords="240,42,293,57" href="ScoreResets.htm" alt="Lift Resets" />
  <area shape="rect" coords="298,42,351,57" href="ScoreSnoozes.htm" alt="Snoozes" />
  <area shape="rect" coords="240,60,351,75" href="ScorePasscode.htm" alt="Pass Code" />
  <area shape="rect" coords="240,78,351,93" href="ScoreTime.htm" alt="Time Remaining" />

  <area shape="rect" coords="360,6,387,32" href="buttonflip.htm" alt="Flip Puzzle or Punch card" />
  <area shape="rect" coords="396,6,423,32" href="buttonmirror.htm" alt="Mirror Puzzle or Punch card" />
  <area shape="rect" coords="432,6,458,32" href="buttonundo.htm" alt="Undo Work Memory" />
  
  <area shape="rect" coords="360,36,387,62" href="buttonyellow.htm" alt="Colour Punchcard Yellow" />
  <area shape="rect" coords="396,36,423,62" href="buttongreen.htm" alt="Colour Punchcard Green" />
  <area shape="rect" coords="432,36,458,62" href="buttonwhite.htm" alt="Colour Punchcard White" />

  <area shape="rect" coords="360,66,387,93" href="buttonaudio.htm" alt="Audio On/Off Button" />
  <area shape="rect" coords="396,66,423,93" href="buttonstats.htm" alt="Game Statistics" />
  <area shape="rect" coords="432,66,458,93" href="buttonpause.htm" alt="Pause Game and Time" />
</map>
