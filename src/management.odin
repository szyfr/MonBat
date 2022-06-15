package main
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import raylib "raylib"
import gra "core/graphics"
import bat   "core/battle"
import ply   "core/player"
import "skald"


//= Main initialization
initialize_core :: proc() -> bool {
	// Raylib initialization
	raylib.set_trace_log_level(7);
	raylib.init_window(screen_width, screen_height, "Roguelite Monster Collector");
	raylib.set_target_fps(60);
	raylib.set_exit_key(raylib.Keyboard_Key.KEY_END);

	// Game initialization
	gra.init();
	ply.init();
	bat.init();

	result := skald.init_skald(texture=gra.graphics.textboxTexture);
	if skald.output_error(result) do return true;

	return false;
}

free_core :: proc() -> bool {


	result := skald.free_skald();
	skald.output_error(result);

	raylib.close_window();

	return false;
}