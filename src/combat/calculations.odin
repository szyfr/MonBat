package combat


//= Imports
import "../monsters"
import "../player"


//= Constants

//= Procedures

//* Timeline positions
//TODO: detach Player. When combat starts, have it add everyone to the timeline
calculate_timeline :: proc(player: ^player.Player, combatData: ^CombatData) -> bool {
	allMonsters:  [dynamic]^monsters.Monster;

	//* Grabbing pointers to all monsters
	if player.playerMonsters[0].initialized do append(&allMonsters, &player.playerMonsters[0]);
	if player.playerMonsters[1].initialized do append(&allMonsters, &player.playerMonsters[1]);
	for i:=0; i<len(combatData.enemyMonsters); i+=1 {
		append(&allMonsters, &combatData.enemyMonsters[i]);
	}

	// Ordering them
	res := monster_sort(&allMonsters);

	combatData.timeline = allMonsters;

	return res;
}

//* Sort timeline
monster_sort       :: proc(list: ^[dynamic]^monsters.Monster) -> bool {
	length := len(list);

	if length < 2 do return true;

	cursor := 0;
	clean: bool = true;

	for {
		if cursor + 2 > length do break;

		if list[cursor].agility < list[cursor+1].agility {
			temp := list[cursor];

			list[cursor]   = list[cursor+1];
			list[cursor+1] = temp;

			clean = false;
		}

		cursor+=1;
	}

	if !clean do monster_sort(list);

	return clean;
}