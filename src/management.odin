package main


//= Imports
import "vendor:raylib"

import "combat"
import "gamedata"
import "graphics"
import "monsters"


//= Constants
DEBUG :: true


//= Procedures

//* Main program loop
main_loop :: proc() {
	using raylib, gamedata

	//* Update

	//* Draw
	BeginDrawing()
	ClearBackground(raylib.RAYWHITE)

	graphics.draw_battle_gui()

	DrawFPS(24,80)

	EndDrawing()
}

//* Initialization
init :: proc() {
	using raylib, gamedata

	//* Raylib Logging
	SetTraceLogLevel(.NONE)

	//* Load Settings / Localization
	//TODO: Settings / Localization

	//* Init Window and framerate
	InitWindow(
		1280,
		720,
		"MonBat",
	)
	SetTargetFPS(80)

	//* Init data
	graphics.init()
	combat.init()

	//* DEBUG
	if DEBUG {
		combat.generate_player_WOOP()
		
		combatdata.active = true
	}
}

//* DeInitialization
free_data :: proc() {
	using raylib

	//* Close raylib
	CloseWindow()

	//* Free data
	graphics.free_data()
	combat.free_data()
}