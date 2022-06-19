package main



//= Imports
import "raylib"


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

// TODO: Get the font working
render_battle :: proc() {
	if battleStructure.isActive {
		// Timeline
		raylib.draw_texture(graphicsStorage.timelineTexture, 0, 0, raylib.WHITE);
		
		// Enemy monsters
		for i:=0; i < len(battleStructure.enemyMonsters); i+=1 {
			monster: ^Monster = &battleStructure.enemyMonsters[i];
			monsterIndex: int = get_monster_texture_index(monster);

			raylib.draw_texture(
				graphicsStorage.monster_frontTextures[monsterIndex],
				screen_width - 200 - (i32(i) * 150), 96,
				raylib.WHITE);

			raylib.draw_text(
				get_monster_name(monster),
				screen_width - 200 - (i32(i) * 150), 224,
				16, raylib.BLACK);
			raylib.draw_text(
				get_monster_health_ratio(monster),
				screen_width - 200 - (i32(i) * 150), 240,
				16, raylib.BLACK);
		}
	}
}