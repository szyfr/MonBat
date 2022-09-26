package mainold


//= Imports
import "vendor:raylib"

import "gamedata"


//= Constants
DEBUG :: true


//= Main
main :: proc() {
	init()
	defer free_data()

	for !raylib.WindowShouldClose() {
		//* Update

		//* Draw
		raylib.BeginDrawing()
		raylib.ClearBackground(raylib.RAYWHITE)

		raylib.DrawFPS(24,80)

		raylib.EndDrawing()
	}
}