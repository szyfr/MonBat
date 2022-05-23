package main
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "raylib"
import gra "core/graphics"
import bat "core/battle"
import ply "core/player"


//= Main initialization
main_init :: proc() {
	// Raylib initialization
	ray.set_trace_log_level(7);
	ray.init_window(screen_width, screen_height, "Roguelite Monster Collector");
	ray.set_target_fps(60);
	ray.set_exit_key(ray.Keyboard_Key.KEY_END);

	// Game initialization
	gra.init();
	ply.init();
	bat.init();

}