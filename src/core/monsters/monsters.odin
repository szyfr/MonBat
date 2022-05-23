package monsters
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/23  //
///=-------------------=///



import fmt "core:fmt"
import str "core:strings"

import ray "../../raylib"


//= Enumerations
MonsterSpecies :: enum { Empty, TEST_PIKACHU, TEST_WOOP, };
MonsterType    :: enum { Empty, Monstrosity, Aberration, Otherworlder, Puck, };
MonsterAttacks :: enum { Empty, Tackle, Growl, };


//= Structs
Monster :: struct {
	playerOwned:    bool,

	monsterSpecies: MonsterSpecies,
	monsterType:    MonsterType,     // Might need this as reference?

	healthCur,
	healthMax:      u32,

	speed:          u8,

	attacks:        [dynamic]MonsterAttacks,
}


//= Procedures

// Checks to see if a monster is initialized
check :: proc(monster: ^Monster) -> bool {
	if monster.monsterSpecies == MonsterSpecies.Empty do return true;
	else do return false;
}

// Clears a monster to unitialized values
clear :: proc(slot: ^Monster) {
	slot.monsterType    = MonsterType.Empty;
	slot.monsterSpecies = MonsterSpecies.Empty;

	slot.healthCur      = 0;
	slot.healthMax      = 0;

	delete(slot.attacks);
	slot.attacks        = make([dynamic]MonsterAttacks);
}

// Copies a Monster from one slot to another
copy :: proc(slot: ^Monster, monster: ^Monster) {
	slot.monsterType    = monster.monsterType;
	slot.monsterSpecies = monster.monsterSpecies;

	slot.healthCur      = monster.healthCur;
	slot.healthMax      = monster.healthMax;

	delete(slot.attacks);
	slot.attacks        = make([dynamic]MonsterAttacks);
	for i := 0; i < len(monster.attacks); i+=1 do append(&slot.attacks, monster.attacks[i]);
}

// Returns cstring of monsters name
name :: proc(monster: ^Monster) -> cstring {
	#partial switch monster.monsterSpecies {
		case .TEST_PIKACHU:
			return "PIKACHU";
		case .TEST_WOOP:
			return "WOOP";
	}

	return "MISSINGNO";
}

// Returns health ratio as a cstring
health_ratio :: proc(monster: ^Monster) -> cstring {
	builder:    str.Builder = {};
	healthStr:  string      = fmt.sbprintf(&builder, "%i / %i", monster.healthCur, monster.healthMax);
	healthCStr: cstring     = str.clone_to_cstring(healthStr);

	delete(healthStr);

	return healthCStr;
}

// Returns index of monsters sprite
sprite :: proc(monster: ^Monster) -> i32 {
	#partial switch monster.monsterSpecies {
		case .TEST_PIKACHU:
			return 1;
		case .TEST_WOOP:
			return 2;
	}

	return 0;
}