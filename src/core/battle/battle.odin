package battle
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/28  //
///=-------------------=///



import fmt "core:fmt"
import str "core:strings"

import ray "../../raylib"
import gra "../graphics"
import mon "../monsters"
import ply "../player"
import "../../skald"


//= Global
battle: ^Battle;


//= Structs
Battle :: struct {
	isActive: bool,

	player: ^ply.Player,
	monsters: [dynamic]mon.Monster,

	timeline: [dynamic]^mon.Monster,
}


//= Constants


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
	testMon1.agility        =  30;

	testMon2: mon.Monster = {};
	testMon1.playerOwned    = false;
	testMon2.monsterSpecies = mon.MonsterSpecies.TEST_PIKACHU;
	testMon2.monsterType    = mon.MonsterType.Puck;
	testMon2.healthCur      = 100;
	testMon2.healthMax      = 100;
	testMon1.agility        =  20;

	append(&battle.monsters, testMon2);
	append(&battle.monsters, testMon2);
	append(&battle.monsters, testMon1);

	battle.player.monsters[0] = testMon1;
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
		ray.draw_texture(gra.graphics.timelineTexture, 0, 0, ray.WHITE);
		ray.draw_text("TIMELINE", 24, 8, 20, ray.BLACK);

		// Enemy monsters
		for i:=0; i < len(battle.monsters); i+=1 {
			// Sprites
			ray.draw_texture(
				gra.graphics.monsterFrontTextures[mon.sprite(&battle.monsters[i])],
				i32(1000 - (i * 224)), 64,
				ray.WHITE);
			
			// Status bar
			ray.draw_text(
				mon.name(&battle.monsters[i]),
				i32(1000 - (i * 224)), 320,
				20, ray.BLACK);
			ray.draw_text(
				mon.health_ratio(&battle.monsters[i]),
				i32(1000 - (i * 224)), 336,
				20, ray.BLACK);
		}

		// Player Monsters
		for i:=0; i < len(ply.player.monsters); i+=1 {
			// Sprites
			ray.draw_texture(
				gra.graphics.monsterBackTextures[mon.sprite(&ply.player.monsters[i])],
				i32(80 + (i * 224)), i32(720 - 256),
				ray.WHITE);
			// Status bar
			ray.draw_text(
				mon.name(&ply.player.monsters[i]),
				i32(80 + (i * 224)), i32(720- 288),
				20, ray.BLACK);
			ray.draw_text(
				mon.health_ratio(&ply.player.monsters[i]),
				i32(80 + (i * 224)), i32(720 - 272),
				20, ray.BLACK);
		}
	}
}