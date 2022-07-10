package main



//= Imports
import "core:fmt"
import "core:math"
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

// - Creation / destruction
create_monster :: proc{ create_monster_ptr, create_monster_full, }
create_monster_ptr :: proc(monster: ^Monster, name: MonsterNames, exp: u32 = 100, player: bool = false) {
	monster.species = name;

	if player do monster.playerOwned = true;

	monster.experience = exp;
	calculate_levelup(monster);

	#partial switch name {
		case .TEST_PIKACHU:
			monster.vitality   = 20;
			monster.mana       = 20;

			monster.strength   = 10;
			monster.magic      = 30;

			monster.endurance  = 10;
			monster.willpower  = 20;

			monster.agility    = 40;
			monster.luck       = 10;
			break;
		case .TEST_WOOP:
			monster.vitality   = 30;
			monster.mana       = 20;

			monster.strength   = 30;
			monster.magic      = 10;

			monster.endurance  = 30;
			monster.willpower  = 20;

			monster.agility    = 20;
			monster.luck       = 20;
			break;
	}

	calculate_health(monster);
	calculate_mana(monster);
}
create_monster_full :: proc(name: MonsterNames, exp: u32 = 100, player: bool = false) -> Monster {
	monster: Monster = {};

	clear_monster(&monster);
	create_monster(&monster, name, exp, player);

	return monster;
}
clear_monster  :: proc(monster: ^Monster) {
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

// - Information
get_monster_name          :: proc(monster: ^Monster) -> cstring {
	#partial switch monster.species {
		case .TEST_PIKACHU:
			return "PIKACHU";
		case .TEST_WOOP:
			return "WOOP";
	}

	return "MISSINGNO";
}
get_monster_texture_index :: proc(monster: ^Monster) -> int {
	return int(monster.species);
}
get_monster_health_ratio  :: proc(monster: ^Monster) -> cstring {
	builder: strings.Builder;
	healthStr:  string  = fmt.sbprintf(&builder, "%i/%i", monster.healthCur, monster.healthMax);
	healthCStr: cstring = strings.clone_to_cstring(healthStr);

	delete(healthStr);

	return healthCStr;
}
// - Calculations
calculate_health  :: proc(monster: ^Monster) {
	total: u32 = (((2 * u32(monster.vitality)) * monster.level) / 100) + monster.level + 10;

	monster.healthCur, monster.healthMax = total, total;
}
calculate_mana    :: proc(monster: ^Monster) {
	total: u32 = (((2 * u32(monster.mana)) * monster.level) / 100) + monster.level;

	monster.manaCur, monster.manaMax = total, total;
}
calculate_exp     :: proc(monster: ^Monster) {
	needed: u32 = u32(math.pow(f32(monster.level + 1), 3));

	if needed >= monster.experience {
		calculate_levelup(monster);
		calculate_exp(monster);
	}
}
calculate_levelup :: proc(monster: ^Monster) {
	// TODO:
	monster.level += 1;
}

// - Interaction
use_attack :: proc(attack: MonsterAttacks) {
	#partial switch (attack) {
		case .Tackle:
		break;
		case .Growl:
		break;
	}
}