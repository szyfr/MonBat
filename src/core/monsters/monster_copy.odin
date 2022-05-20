package monsters
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"


//= Clears monster slot
monster_copy_slot :: proc(slot: ^Monster, monster: ^Monster) {
	slot.monsterType    = monster.monsterType;
	slot.monsterSpecies = monster.monsterSpecies;

	slot.healthCur      = monster.healthCur;
	slot.healthMax      = monster.healthMax;

	delete(slot.attacks);
	slot.attacks        = make([dynamic]MonsterAttacks);
	for i := 0; i < len(monster.attacks); i+=1 do append(&slot.attacks, monster.attacks[i]);
}