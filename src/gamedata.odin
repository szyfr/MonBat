package main


//= Imports
import "raylib"
import "skald"

import "graphics"
import "player"


//= Constants
SCREEN_WIDTH  :   i32   : 1280
SCREEN_HEIGHT :   i32   :  720
SCREEN_TITLE  : cstring : "Rogue-lite monster collector"


//= Global Variables
gamedata : ^GameData


//= Structures
GameData :: struct {
	player       : ^player.Player,
	graphicsData : ^graphics.GraphicsData,
}


//= Procedures
//*  Reification of core data
initialize_core :: proc() {
	//* Raylib
	raylib.set_trace_log_level(7)
	raylib.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE)
	raylib.set_target_fps(60)
	raylib.set_exit_key(raylib.Keyboard_Key.KEY_END)

	//* Game
	gamedata              = new(GameData)
	gamedata.player       = player.init()
	gamedata.graphicsData = graphics.init()

	//* Other
	skald.init_skald(
		texture = gamedata.graphicsData.textboxTexture,
		font    = gamedata.graphicsData.font,
		speed   = 0,
	)
}
free_core :: proc() {
	//* Other

	//* Game
	player.free(gamedata.player)
	graphics.free(gamedata.graphicsData)
	free(gamedata)
	
	//* Raylib
	raylib.close_window();
}