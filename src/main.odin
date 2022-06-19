package main
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



import "core:fmt"
import "core:strings"

import ray "raylib"
import gra "core/graphics"
import txt "core/textbox"
import bat "core/battle"
import mon "core/monsters"
import ply "core/player"
import "skald"


test_proc1 :: proc() { fmt.printf("fuck1\n"); }
test_proc2 :: proc() { fmt.printf("fuck2\n"); }

//= Main
main :: proc() {

	result := initialize_core();
	if result {
		free_core();
		return;
	}

	text: [dynamic]string;
	append(&text, "Testing 1");
	options: [dynamic]skald.MenuOption;
	append(&options, skald.MenuOption{"TEST1",test_proc1}, skald.MenuOption{"TEST2",test_proc2});
	skald.create_textbox(
		position=ray.Vector2{680,400}, size=ray.Vector2{600,320}, offset=ray.Vector2{32,32},
		textDynamic=text,
		options=options);


	for !ray.window_should_close() {
		// Updating
		{
		//	if ray.is_key_down(ray.Keyboard_Key.KEY_W) do ply.player.camera.offset.y += 1;
		//	if ray.is_key_down(ray.Keyboard_Key.KEY_S) do ply.player.camera.offset.y -= 1;
		//	if ray.is_key_down(ray.Keyboard_Key.KEY_A) do ply.player.camera.offset.x += 1;
		//	if ray.is_key_down(ray.Keyboard_Key.KEY_D) do ply.player.camera.offset.x -= 1;

			if ray.is_key_pressed(ray.Keyboard_Key.KEY_P) do bat.start_battle();

			skald.update_textboxes();
		}

		// Drawing
		{
			ray.begin_drawing();
				ray.clear_background(ray.RAYWHITE);

				ray.begin_mode2d(ply.player.camera);

					skald.draw_textboxes();

					bat.render_battle();

					ray.draw_fps((8 * 3), (8 * 5));

				ray.end_mode2d();
			ray.end_drawing();
		}
	}

	ray.close_window();
}
