package main
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



import "core:fmt"
import "core:strings"

import ray "raylib"
import gra "core/graphics"
import bat "core/battle"
import mon "core/monsters"
import ply "core/player"


//= Main
main :: proc() {

	main_init();

	for !ray.window_should_close() {
		// Updating
		{
			if ray.is_key_down(ray.Keyboard_Key.KEY_W) do ply.player.camera.offset.y += 1;
			if ray.is_key_down(ray.Keyboard_Key.KEY_S) do ply.player.camera.offset.y -= 1;
			if ray.is_key_down(ray.Keyboard_Key.KEY_A) do ply.player.camera.offset.x += 1;
			if ray.is_key_down(ray.Keyboard_Key.KEY_D) do ply.player.camera.offset.x -= 1;

			if ray.is_key_pressed(ray.Keyboard_Key.KEY_P) do bat.start_battle();
		}

		// Drawing
		{
			ray.begin_drawing();
				ray.clear_background(ray.RAYWHITE);

				ray.begin_mode2d(ply.player.camera);
					
					bat.render_battle();

				ray.end_mode2d();
			ray.end_drawing();
		}
	}

	ray.close_window();
}
