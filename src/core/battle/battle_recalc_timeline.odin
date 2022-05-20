package battle
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"
import mon "../monsters"
import ply "../player"


//= Recalculate battle timeline
// TODO: figure out a good algorithm for this
battle_recalc_timeline :: proc() {
	// Reset timeline
	delete(battle.timeline);
	
	// Add in player monsters
	// TODO: clean up, this looks bad
	append(&battle.timeline, &battle.player.monsters[0]);
	if mon.monster_check(battle.player.monsters[1]) {
		append(&battle.timeline, &battle.player.monsters[1]);
	}

	// Add in enemy monsters
	for i:=0; i < len(battle.monsters); i+=1 {
		append(&battle.timeline, &battle.monsters[i]);
	}
}