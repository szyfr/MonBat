package mainold


//= Imports
import "vendor:raylib"

import "gamedata"
import "graphics"
import "monsters"
import "player"


//= Procedures
init :: proc() {
	using raylib, gamedata

	//* Raylib Logging
	SetTraceLogLevel(.NONE)

	//* Load Settings / Localization

	//* Init Window and framerate
	//TODO: Settings
	InitWindow(
		1280,
		720,
		"MonBat",
	)
	SetTargetFPS(80)

	//* Load graphics
	graphics.init()
	player.init()

	//* Debug
	if DEBUG {
		playerdata.playerMonsters[0] = monsters.create_monster(name=.TEST_WOOP, player=true)
	}
}
free_data :: proc() {
	using raylib, gamedata

	//* Close raylib
	CloseWindow()

	//* Free data
	graphics.free_data()
	player.free_data()
}