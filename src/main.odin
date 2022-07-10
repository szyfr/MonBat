package main



//= Imports
import "core:fmt"
import "core:strings"

import "raylib"
import "skald"


//= Constants
screen_width  : i32 : 1280;
screen_height : i32 : 720;


//= Global Variables

//= Structures

//= Enumerations

//= Procedures

test_proc1 :: proc() { fmt.printf("fuck1\n"); }
test_proc2 :: proc() { fmt.printf("fuck2\n"); }

//- Main
main :: proc() {

	initialize_core();

	battleStructure.isActive = true;

	testMon1: Monster = create_monster(name=.TEST_WOOP,    exp=1000);
	testMon2: Monster = create_monster(name=.TEST_PIKACHU, exp=11000);
	testMon3: Monster = create_monster(name=.TEST_WOOP,    exp=14000);

	append(&battleStructure.enemyMonsters, testMon1, testMon1, testMon2, testMon3);
	create_monster(
		monster = &player.monsters[0],
		name    = .TEST_WOOP,
		exp     = 1000,
		player  = true);
	create_monster(
		monster = &player.monsters[1],
		name    = .TEST_PIKACHU,
		exp     = 1000,
		player  = true);

	calculate_timeline();

	for !raylib.window_should_close() {
		// Updating
		{
			if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_P) do increment_turn();

		//	if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_P) do bat.start_battle();
			update_battle();
			skald.update_textboxes();
		}

		// Drawing
		{
			raylib.begin_drawing();
				raylib.clear_background(raylib.RAYWHITE);

				skald.draw_textboxes();
				render_battle();
				
				raylib.draw_fps((8 * 3), (8 * 10));

			raylib.end_drawing();
		}
	}

	free_core();
}


// - Core initialization and freeing
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
	skald.init_skald(texture=graphicsStorage.textboxTexture, font=graphicsStorage.font);
}
free_core :: proc() {
	
	free_graphics();
	free_player();
	free_battle();

	skald.free_skald();

	raylib.close_window();
}