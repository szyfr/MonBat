package main


//= Imports
import "core:fmt"
import "core:strings"

import "raylib"
import "skald"


//=  Main
main :: proc() {

	initialize_core()

	for !raylib.window_should_close() {
		//* Update

		//* Draw
		raylib.begin_drawing()
		raylib.clear_background(raylib.RAYWHITE)

		raylib.draw_fps(24, 80);

		raylib.end_drawing()
	}

	free_core()
}