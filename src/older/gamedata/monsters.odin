package gamedata


//= Imports


//= Structures
Monster :: struct {
	species   : MonsterNames,

	healthCur , healthMax  : u32,
	manaCur   , manaMax    : u32,
	level     , experience : u32,

	vitality  , mana            ,
	strength  , magic           ,
	endurance , willpower       ,
	agility   , luck       :  u8,

	attacks   : [dynamic]MonsterAttacks,

	player    : bool,
}


//= Enumerations
MonsterNames :: enum {
	empty,

	TEST_PIKACHU, TEST_WOOP,
}
MonsterTypes   :: enum {
	empty,
	Monstrosity,
	Aberration,
	Otherworlder,
	Puck,
}
MonsterAttacks :: enum {
	empty,

	// Monstrosity
	Tackle, Growl,
	// Aberration
	// Otherworlder
	// Puck
	ThunderShock,
}