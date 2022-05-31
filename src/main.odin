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


//= Main
main :: proc() {

	main_init();

//	test := txt.init_textbox();
	test := txt.init_textbox(texture=gra.graphics.textboxTexture,npatch=gra.graphics.textboxNPatch);
	fmt.printf("%i\n", test);

	text: [dynamic]string = make([dynamic]string);
	append(&text, "Fuck me up and down");
	append(&text, "Fuck me sideways and frontways");
	append(&text, "I wanna die bad.");
	test  = txt.create_textbox(position={0,500},size={400,200}, text=text);
	fmt.printf("%i\n", test);

	for !ray.window_should_close() {
		// Updating
		{
			if ray.is_key_down(ray.Keyboard_Key.KEY_W) do ply.player.camera.offset.y += 1;
			if ray.is_key_down(ray.Keyboard_Key.KEY_S) do ply.player.camera.offset.y -= 1;
			if ray.is_key_down(ray.Keyboard_Key.KEY_A) do ply.player.camera.offset.x += 1;
			if ray.is_key_down(ray.Keyboard_Key.KEY_D) do ply.player.camera.offset.x -= 1;

			if ray.is_key_pressed(ray.Keyboard_Key.KEY_P) do bat.start_battle();

			txt.update_textboxes();
		}

		// Drawing
		{
			ray.begin_drawing();
				ray.clear_background(ray.RAYWHITE);

				ray.begin_mode2d(ply.player.camera);
					
					txt.draw_textboxes();

					bat.render_battle();

					ray.draw_fps((8 * 3), (8 * 5));

				ray.end_mode2d();
			ray.end_drawing();
		}
	}

	ray.close_window();
}
