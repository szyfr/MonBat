package battle
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/23  //
///=-------------------=///



import fmt "core:fmt"
import str "core:strings"

import ray "../../raylib"
import gra "../graphics"
import mon "../monsters"
import ply "../player"


//= Global
battle: ^Battle;


//= Structs
Battle :: struct {
	isActive: bool,

	player: ^ply.Player,
	monsters: [dynamic]mon.Monster,

	timeline: [dynamic]^mon.Monster,
}


//= Procedures

// Initialize battle structure
init :: proc() {
	battle = new(Battle);

	battle.isActive = false;
	battle.player = ply.player;
}

// Start a battle
// TODO: make this into something of non-testing value
start_battle :: proc() {
	if battle.isActive do return;
	battle.isActive = true;

	testMon1: mon.Monster = {};
	testMon1.playerOwned    = false;
	testMon1.monsterSpecies = mon.MonsterSpecies.TEST_WOOP;
	testMon1.monsterType    = mon.MonsterType.Monstrosity;
	testMon1.healthCur      = 100;
	testMon1.healthMax      = 100;
	testMon1.speed          =  20;

	testMon2: mon.Monster = {};
	testMon1.playerOwned    = false;
	testMon2.monsterSpecies = mon.MonsterSpecies.TEST_PIKACHU;
	testMon2.monsterType    = mon.MonsterType.Puck;
	testMon2.healthCur      = 100;
	testMon2.healthMax      = 100;
	testMon2.speed          =  20;

	append(&battle.monsters, testMon2);
	append(&battle.monsters, testMon2);
	append(&battle.monsters, testMon1);
}

// Recalculate battle timeline
// TODO: figure out a good algorithm for this
recalc_timeline :: proc() {
	// Reset timeline
	delete(battle.timeline);
	
	// Add in player monsters
	// TODO: clean up, this looks bad
	append(&battle.timeline, &battle.player.monsters[0]);
	if mon.check(&battle.player.monsters[1]) {
		append(&battle.timeline, &battle.player.monsters[1]);
	}

	// Add in enemy monsters
	for i:=0; i < len(battle.monsters); i+=1 {
		append(&battle.timeline, &battle.monsters[i]);
	}
}

// Render ongoing battle
// TODO: calculate enemy location based on screen size      ;; 
// TODO: Enemies are displayed in reverse order             ;; Talk to Jarrod about how we want this to look!!!
// TODO: also calc with number of enemies as it could grow  ;; 
// TODO: Timeline
// TODO: Menus / text boxes
// TODO: Import a font
render_battle :: proc() {
	if battle.isActive {
		// Timeline
		img: ray.Image   = ray.gen_image_color(1280,64,ray.BLACK);
		tex: ray.Texture = ray.load_texture_from_image(img);
		ray.draw_texture(tex,0,0,ray.WHITE);
		ray.unload_image(img);
		ray.unload_texture(tex);
		ray.draw_text("TIMELINE...", 16, 16, 20, ray.WHITE);

		// Enemy monsters
		for i:=0; i < len(battle.monsters); i+=1 {
			// Sprites
			ray.draw_texture(gra.graphics.monsterFrontTextures[mon.sprite(&battle.monsters[i])], i32(1000-(i*200)),64, ray.WHITE);
			// Status bar
			ray.draw_text(mon.name(        &battle.monsters[i]), 32, i32((i*64) +  96),20,ray.BLACK);
			ray.draw_text(mon.health_ratio(&battle.monsters[i]), 32, i32((i*64) + 112),20,ray.BLACK);
		}

		// Player Monsters
		for i:=0; i < len(ply.player.monsters); i+=1 {
			// Sprites
			ray.draw_texture(gra.graphics.monsterBackTextures[mon.sprite(&ply.player.monsters[i])], i32(80+(i*200)),i32(720-220), ray.WHITE);
			// Status bar
			ray.draw_text(mon.name(        &ply.player.monsters[i]), i32(600), i32(550 + (i*80)),20,ray.BLACK);
			ray.draw_text(mon.health_ratio(&ply.player.monsters[i]), i32(600), i32(566 + (i*80)),20,ray.BLACK);
		}

		// Menu / Text boxes
		ray.draw_texture_n_patch(gra.graphics.textboxTexture, gra.graphics.textboxNPatch, ray.Rectangle{800,400,480,320}, ray.Vector2{0,0}, 0, ray.WHITE);
	}
}