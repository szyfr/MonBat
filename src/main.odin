package main


//= Imports
import "vendor:raylib"


//= Main
main :: proc() {
	init()
	defer free_data()

	for !raylib.WindowShouldClose() do main_loop()
}