package gamedata


//= Imports


//= Structures
Monster :: struct {

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