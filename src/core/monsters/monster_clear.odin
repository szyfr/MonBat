package monsters
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"


//= Clears monster slot
monster_clear_slot :: proc(slot: ^Monster) {
	slot.monsterType    = MonsterType.Empty;
	slot.monsterSpecies = MonsterSpecies.Empty;

	slot.healthCur      = 0;
	slot.healthMax      = 0;

	delete(slot.attacks);
	slot.attacks        = make([dynamic]MonsterAttacks);
}