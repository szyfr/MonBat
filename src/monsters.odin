package main



//= Imports
import "core:fmt"
import "core:strings"


//= Constants

//= Global Variables

//= Structures
Monster :: struct {
	initialized: bool,
	playerOwned: bool,

	species: MonsterNames,

	healthCur, healthMax:  u32,
	manaCur,   manaMax:    u32,
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

	SIZE, };
MonsterTypes   :: enum { empty, Monstrosity, Aberration, Otherworlder, Puck, };
MonsterAttacks :: enum {
	empty,

	// Monstrosity
	Tackle, Growl,
	// Aberration
	// Otherworlder
	// Puck

	SIZE, };


//= Procedures

clear_monster :: proc(monster: ^Monster) {
	monster.species = .empty;

	monster.healthCur  = 0;
	monster.healthMax  = 0;
	monster.manaCur    = 0;
	monster.manaMax    = 0;
	monster.level      = 0;
	monster.experience = 0;
	monster.vitality   = 0;
	monster.mana       = 0;
	monster.strength   = 0;
	monster.magic      = 0;
	monster.endurance  = 0;
	monster.willpower  = 0;
	monster.agility    = 0;
	monster.luck       = 0;

	delete(monster.attacks);
	monster.attacks = make([dynamic]MonsterAttacks);
}

get_monster_name          :: proc(monster: ^Monster) -> cstring {
	#partial switch monster.species {
		case .TEST_PIKACHU:
			return "PIKACHU";
		case .TEST_WOOP:
			return "WOOP";
	}

	return "MISSINGNO"; }
get_monster_texture_index :: proc(monster: ^Monster) -> int {
	return int(monster.species); }
get_monster_health_ratio  :: proc(monster: ^Monster) -> cstring {
	builder: strings.Builder;
	healthStr:  string  = fmt.sbprintf(&builder, "%i/%i", monster.healthCur, monster.healthMax);
	healthCStr: cstring = strings.clone_to_cstring(healthStr);

	delete(healthStr);

	return healthCStr; }