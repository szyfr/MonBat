package combat


//= Imports
import "../monsters"


//= Structures
CombatData :: struct {
	isActive      : bool,

	enemyMonsters : [dynamic]monsters.Monster,
	timeline      : [dynamic]^monsters.Monster,
	
	turnPosition  : u32,
	roundPosition : u32,

	turnUpdated   : bool,
	target        : int,
}


//= Enumerations