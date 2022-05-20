package monsters
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"


//= Enumerations
MonsterSpecies :: enum {
	Empty,
	TEST_PIKACHU,
	TEST_BULBASAUR,
}
MonsterType :: enum {
	Empty,
	Monstrosity,
	Aberration,
	Otherworlder,
	Puck,
}
MonsterAttacks :: enum {
	Empty,
	Tackle,
	Growl,
}


//= Structs
Monster :: struct {
	monsterSpecies: MonsterSpecies,
	monsterType:    MonsterType,     // Might need this as reference?

	healthCur,
	healthMax:      u32,

	speed:          u8,

	attacks:        [dynamic]MonsterAttacks,
}