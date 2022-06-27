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

//	text: [dynamic]string;
//	append(&text, "Testing 1");
//	options: [dynamic]skald.MenuOption;
//	append(&options, skald.MenuOption{"TEST1",test_proc1}, skald.MenuOption{"TEST2",test_proc2});
//	skald.create_textbox(
//		textboxRect=raylib.Rectangle{680,400,600,320}, offset=raylib.Vector2{32,32},
//		textDynamic=text,fontSize=16,
//		options=options);

	battleStructure.isActive = true;

	testMon1: Monster = {};
	testMon1.initialized = true;
	testMon1.species     = .TEST_WOOP;
	testMon1.healthCur   = 100;
	testMon1.healthMax   = 100;
	testMon1.agility     =  30;

	testMon2: Monster = {};
	testMon2.initialized = true;
	testMon2.species     = .TEST_PIKACHU;
	testMon2.healthCur   = 100;
	testMon2.healthMax   = 100;
	testMon2.agility     =  40;

	testMon3: Monster = {};
	testMon3.initialized = true;
	testMon3.species     = .TEST_WOOP;
	testMon3.healthCur   = 100;
	testMon3.healthMax   = 100;
	testMon3.agility     =  60;

	testMon4: Monster = {};
	testMon4.initialized = true;
	testMon4.species     = .TEST_PIKACHU;
	testMon4.healthCur   = 100;
	testMon4.healthMax   = 100;
	testMon4.agility     =  10;

	append(&battleStructure.enemyMonsters, testMon1, testMon1, testMon2, testMon4, testMon4);
	player.monsters[0] = testMon4;
	player.monsters[0].playerOwned = true;
	player.monsters[1] = testMon1;
	player.monsters[1].playerOwned = true;

	calculate_timeline();

	for !raylib.window_should_close() {
		// Updating
		{
		//	if ray.is_key_down(ray.Keyboard_Key.KEY_W) do ply.player.camera.offset.y += 1;
		//	if ray.is_key_down(ray.Keyboard_Key.KEY_S) do ply.player.camera.offset.y -= 1;
		//	if ray.is_key_down(ray.Keyboard_Key.KEY_A) do ply.player.camera.offset.x += 1;
		//	if ray.is_key_down(ray.Keyboard_Key.KEY_D) do ply.player.camera.offset.x -= 1;
			if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_P) do battleStructure.turnPosition += 1;
			if raylib.is_key_pressed(raylib.Keyboard_Key.KEY_O) do battleStructure.turnPosition -= 1;

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
