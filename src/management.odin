package main
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import "raylib"
import "skald"


//= Main initialization
initialize_core :: proc() {
	// Raylib
	raylib.set_trace_log_level(7);
	raylib.init_window(screen_width, screen_height, "Roguelite Monster Collector without a name");
	raylib.set_target_fps(60);
	raylib.set_exit_key(raylib.Keyboard_Key.KEY_END);

	// Game
	initialize_graphics(2);
	initialize_player();
	initialize_battle();

	// Outside packages
	skald.init_skald(texture=graphicsStorage.textboxTexture);
}

free_core :: proc() {
	
	free_graphics();
	free_player();
	free_battle();

//	skald.free_skald();

	raylib.close_window();
}