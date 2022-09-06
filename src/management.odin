package main


//= Imports
import "vendor:raylib"

import "gamedata"
import "graphics"
import "player"


//= Procedures
init :: proc() {
	using raylib, gamedata

	//* Raylib Logging
	SetTraceLogLevel(.NONE)

	//* Init gamedata
	gamedata = new(GameData)

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

	//* Debug logging
//	if DEBUG do 
}
free_data :: proc() {
	using raylib, gamedata

	//* Close raylib
	CloseWindow()

	//* Free data
	graphics.free_data()
	player.free_data()

	free(gamedata)
}