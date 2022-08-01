package combat


//= Imports
import "core:strings"

import "../monsters"
import "../player"


//= Constants

//= Procedures

//* Get enemy list
get_enemy_list :: proc(combatData: ^CombatData) -> [dynamic]string {
	str: [dynamic]string;

	for i:=0; i<len(combatData.enemyMonsters); i+=1 {
		cstr: cstring = monsters.get_monster_name(&combatData.enemyMonsters[i]);
		append(&str, strings.clone_from_cstring(cstr));
	}

	return str;
}