package main



//= Imports
import "raylib"
import "core:fmt"


//= Constants

//= Global Variables
battleStructure: ^BattleStructure;


//= Structures
BattleStructure :: struct {
	isActive:      bool,

	enemyMonsters: [dynamic]Monster,
	timeline:      [dynamic]^Monster,
	turnPosition:  u32,
};


//= Enumerations

//= Procedures

//- Initialization
initialize_battle :: proc() {
	battleStructure = new(BattleStructure);

	battleStructure.isActive      = false;
	battleStructure.enemyMonsters = make([dynamic]Monster);
	battleStructure.timeline      = make([dynamic]^Monster);
}
free_battle :: proc() {
	delete(battleStructure.enemyMonsters);
	delete(battleStructure.timeline);
	free(battleStructure);
}

//- Utilities
calculate_timeline :: proc() -> bool {
	allMonsters:  [dynamic]^Monster;

	// Grabbing pointers to all monsters
	if player.monsters[0].initialized do append(&allMonsters, &player.monsters[0]);
	if player.monsters[1].initialized do append(&allMonsters, &player.monsters[1]);
	for i:=0; i<len(battleStructure.enemyMonsters); i+=1 {
		append(&allMonsters, &battleStructure.enemyMonsters[i]);
	}

	// Ordering them
	res := monster_sort(&allMonsters);

	battleStructure.timeline = allMonsters;

	return res;
}
monster_sort :: proc(list: ^[dynamic]^Monster) -> bool {
	length := len(list);

	if length < 2 do return true;

	cursor := 0;
	clean: bool = true;

	for {
		if cursor + 2 > length do break;

		if list[cursor].agility < list[cursor+1].agility {
			temp := list[cursor];

			list[cursor]   = list[cursor+1];
			list[cursor+1] = temp;

			clean = false;
		}

		cursor+=1;
	}

	if !clean do monster_sort(list);

	return clean;
}

//- Logic / Draw
update_battle :: proc() {

	for i:=0; i<len(battleStructure.timeline); i+=1 {
		if battleStructure.timeline[i].playerOwned do fmt.printf("player.%s: %i, ", get_monster_name(battleStructure.timeline[i]), battleStructure.timeline[i].agility);
		else                                       do fmt.printf("enemy.%s: %i, ",  get_monster_name(battleStructure.timeline[i]), battleStructure.timeline[i].agility);

	}
	fmt.printf("\n");
}
render_battle :: proc() {
	if battleStructure.isActive {
		// Timeline
		raylib.draw_texture(graphicsStorage.timelineTexture, 0, 32, raylib.WHITE);

		// Calculate min/max

		for i:=0; i<len(battleStructure.timeline); i+=1 {
			color: raylib.Color;
			if battleStructure.timeline[i].playerOwned do color = raylib.GREEN;
			else                                       do color = raylib.RED;

			position: f32 = (f32(i) / f32(len(battleStructure.timeline) - 1));
			offset:   f32 = -f32((f32(battleStructure.turnPosition) / f32(len(battleStructure.timeline)-1)) * 568);

			raylib.draw_texture(graphicsStorage.timelineIcon, i32(position * 568) + 50 + i32(offset), 0, color);
		}

	//	max, min := battleStructure.timeline[0].agility, battleStructure.timeline[len(battleStructure.timeline)-1].agility;
	//	last, ticker: f32 = 100, 0;
	//	
	//	for i:=0; i<len(battleStructure.timeline); i+=1 {
	//		color: raylib.Color;
	//		if battleStructure.timeline[i].playerOwned do color = raylib.GREEN;
	//		else                                       do color = raylib.RED;
//
	//		position: f32 = 1 - (f32(battleStructure.timeline[i].agility - min) / f32(max - min));
	//		if last == position {
	//			ticker   += 1;
	//			position += 0.05 * ticker;
	//		//	if int(battleStructure.turnPosition) == i do offset = i32(position * 568);
	//		} else {
	//			ticker = 0;
	//			last = position;
	//		}
//
//
	//		raylib.draw_texture(graphicsStorage.timelineIcon, i32(position * 568) + 50, 0, color);
	//	}
		
		// Enemy monsters
		for i:=0; i < len(battleStructure.enemyMonsters); i+=1 {
			monster: ^Monster = &battleStructure.enemyMonsters[i];
			monsterIndex: int = get_monster_texture_index(monster);

			raylib.draw_texture(
				graphicsStorage.monster_frontTextures[monsterIndex],
				screen_width - 200 - (i32(i) * 150), 96,
				raylib.WHITE);

			raylib.draw_text_ex(
				graphicsStorage.font,
				get_monster_name(monster),
				raylib.Vector2{f32(screen_width) - 200 - (f32(i) * 150), 224},
				16, 1, raylib.BLACK);
			raylib.draw_text_ex(
				graphicsStorage.font,
				get_monster_health_ratio(monster),
				raylib.Vector2{f32(screen_width) - 200 - (f32(i) * 150), 240},
				16, 1, raylib.BLACK);
		}
	}
}