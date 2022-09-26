package monsters


//= Imports
import "core:fmt"
import "core:strings"


//= Constants

//= Procedures

//* Monster Name
get_monster_name          :: proc(monster: ^Monster) -> cstring {
	#partial switch monster.species {
		case .TEST_PIKACHU:
			return "PIKACHU";
		case .TEST_WOOP:
			return "WOOP";
	}

	return "MISSINGNO";
}

//* Monster type
get_monster_type          :: proc(monster: ^Monster) -> MonsterTypes {
	#partial switch monster.species {
		case .TEST_PIKACHU:
			return .Puck;
		case .TEST_WOOP:
			return .Monstrosity;
	}
	return .empty;
}

//* Monster texture index
get_monster_texture_index :: proc(monster: ^Monster) -> int {
	return int(monster.species);
}

//* Monster Health ratio
get_monster_health_ratio  :: proc(monster: ^Monster) -> cstring {
	builder: strings.Builder;
	healthStr:  string  = fmt.sbprintf(&builder, "%i/%i", monster.healthCur, monster.healthMax);
	healthCStr: cstring = strings.clone_to_cstring(healthStr);

	delete(healthStr);

	return healthCStr;
}

//* Monster attack list
get_monster_attack_list   :: proc(monster: ^Monster) -> [dynamic]string {
	str: [dynamic]string;


	for i:=0; i<len(monster.attacks); i+=1 {
		cstr: cstring = get_monster_attack(monster, i);
		append(&str, strings.clone_from_cstring(cstr));
	}

	return str;
}

//* Attack name
get_monster_attack        :: proc(monster: ^Monster, index: int) -> cstring {
	#partial switch monster.attacks[index] {
		case .Tackle:       return "Tackle";
		case .Growl:        return "Growl";
		case .ThunderShock: return "Thunder shock";
	}
	return "NULL";
}

//* Compare monsters
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

