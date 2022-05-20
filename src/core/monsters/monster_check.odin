package monsters
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"


//= 
monster_check :: proc(monster: Monster) -> bool {
	if monster.monsterSpecies == MonsterSpecies.Empty do return true;
	else do return false;
}