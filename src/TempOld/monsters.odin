package TempOld



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

	SIZE, };
MonsterTypes   :: enum { empty, Monstrosity, Aberration, Otherworlder, Puck, };
MonsterAttacks :: enum {
	empty,

	// Monstrosity
	Tackle, Growl,
	// Aberration
	// Otherworlder
	// Puck
	ThunderShock,

	SIZE, };


//= Procedures

// - Creation / destruction
create_monster      :: proc{ create_monster_ptr, create_monster_full, }
create_monster_ptr  :: proc(monster: ^Monster, name: MonsterNames, exp: u32 = 100, player: bool = false) {
	monster.species = name;
	monster.initialized = true;

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

			append(&monster.attacks, MonsterAttacks.ThunderShock, MonsterAttacks.Growl);
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

			append(&monster.attacks, MonsterAttacks.Tackle, MonsterAttacks.Growl);
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
clear_monster       :: proc(monster: ^Monster) {
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
kill_monster        :: proc(monster: ^Monster) {
	temp: int = 0;

	for i:=0; i<len(battleStructure.enemyMonsters); i+=1 {
		if compare_monsters(&battleStructure.enemyMonsters[i], monster) do break;
	}

	//TODO: replace this with and actual deletion. 
	clear_monster(&battleStructure.enemyMonsters[temp]);
	calculate_timeline();
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
get_monster_type          :: proc(monster: ^Monster) -> MonsterTypes {
	#partial switch monster.species {
		case .TEST_PIKACHU:
			return .Puck;
		case .TEST_WOOP:
			return .Monstrosity;
	}
	return .empty;
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
get_monster_attack        :: proc(monster: ^Monster, index: int) -> cstring {
	#partial switch monster.attacks[index] {
		case .Tackle:       return "Tackle";
		case .Growl:        return "Growl";
		case .ThunderShock: return "Thunder shock";
	}
	return "NULL";
}
get_monster_attack_list   :: proc(monster: ^Monster) -> [dynamic]string {
	str: [dynamic]string;


	for i:=0; i<len(monster.attacks); i+=1 {
		cstr: cstring = get_monster_attack(monster, i);
		append(&str, strings.clone_from_cstring(cstr));
	}

	return str;
}
compare_monsters          :: proc(mon1: ^Monster, mon2: ^Monster) -> bool {
	result: bool = true;

	if mon1.species != mon2.species       do result = false;

	if mon1.healthCur != mon2.healthCur   do result = false;
	if mon1.healthMax != mon2.healthMax   do result = false;

	if mon1.manaCur != mon2.manaCur       do result = false;
	if mon1.manaMax != mon2.manaMax       do result = false;

	if mon1.level != mon2.level           do result = false;
	if mon1.experience != mon2.experience do result = false;

	return result;
}

// - Calculations
calculate_health  :: proc(monster: ^Monster) {
	total: i32 = (((2 * i32(monster.vitality)) * i32(monster.level)) / 100) + i32(monster.level) + 10;

	monster.healthCur, monster.healthMax = total, total;
}
calculate_mana    :: proc(monster: ^Monster) {
	total: i32 = (((2 * i32(monster.mana)) * i32(monster.level)) / 100) + i32(monster.level);

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
// TODO: Update to have actual calculations
use_attack :: proc(user: ^Monster, target: ^Monster, moveIndex: int) {
	#partial switch user.attacks[moveIndex] {
		case .Tackle:
			target.healthCur -= 10;
			break;
		case .Growl:
			break;
		case .ThunderShock:
			target.healthCur -= 10;
			break;
	}

	if target.healthCur <= 0 {
		kill_monster(target);
	}
}