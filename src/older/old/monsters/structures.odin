package monsters


//= Imports

//= Structures
Monster :: struct {
	initialized: bool,
	playerOwned: bool,

	species: MonsterNames,

	healthCur, healthMax:  i32,
	manaCur,   manaMax:    i32,
	level,     experience: u32,

	vitality,  mana,
	strength,  magic,
	endurance, willpower,
	agility,   luck:      u8,

	attacks: [dynamic]MonsterAttacks,
};


//= Enumerations
MonsterNames   :: enum {
	empty,

	TEST_PIKACHU, TEST_WOOP,

	SIZE,
};
MonsterTypes   :: enum {
	empty,
	Monstrosity,
	Aberration,
	Otherworlder,
	Puck,
};
MonsterAttacks :: enum {
	empty,

	// Monstrosity
	Tackle, Growl,
	// Aberration
	// Otherworlder
	// Puck
	ThunderShock,

	SIZE,
};