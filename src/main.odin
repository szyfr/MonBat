package main
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



import "core:fmt"
import "core:strings"

import ray "raylib"
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
					image:   ray.Image   = ray.gen_image_color(64,64,ray.BLACK);
					texture: ray.Texture = ray.load_texture_from_image(image);
					
					if bat.battle.isActive {
						for i:=0; i < len(bat.battle.monsters); i+=1 {
							ray.draw_texture(texture, i32(16+(i*72)),32, ray.WHITE);
						}
					}

					ray.unload_image(image);
					ray.unload_texture(texture);
				ray.end_mode2d();
			ray.end_drawing();
		}
	}

	ray.close_window();
}
