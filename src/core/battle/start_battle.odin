package battle
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"
import mon "../monsters"


//= Start a battle
// TODO: make this into something of non-testing value
start_battle :: proc() {
	battle.isActive = true;

	testMon1: mon.Monster = {};
	testMon1.monsterSpecies = mon.MonsterSpecies.TEST_PIKACHU;
	testMon1.monsterType    = mon.MonsterType.Puck;
	testMon1.healthCur      = 100;
	testMon1.healthMax      = 100;
	testMon1.speed          =  20;

	append(&battle.monsters, testMon1);
	append(&battle.monsters, testMon1);
	append(&battle.monsters, testMon1);
}