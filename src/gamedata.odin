package main


//= Imports
import "raylib"

import "player"


//= Constants
SCREEN_WIDTH  :   i32   : 1280
SCREEN_HEIGHT :   i32   :  720
SCREEN_TITLE  : cstring : "Rogue-lite monster collector"


//= Global Variables
gamedata : ^GameData


//= Structures
GameData :: struct {
	player : ^player.Player,
}


//= Procedures
//*  Initialize / Free core data
initialize_core :: proc() {
	//* Raylib
	raylib.set_trace_log_level(7)
	raylib.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE)
	raylib.set_target_fps(60)
	raylib.set_exit_key(raylib.Keyboard_Key.KEY_END)

	//* Game
	gamedata        = new(GameData)
	gamedata.player = player.init()

	//* Other
//	skald.init_skald()
}
free_core :: proc() {
	//* Other

	//* Game
	player.free(gamedata.player)
	
	//* Raylib
	raylib.close_window();
}