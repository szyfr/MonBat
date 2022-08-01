package combat


//= Imports
import "../skald"

import "../monsters"
import "../player"


//= Constants

//= Procedures

//* Choose Target
choose_target :: proc(combatData: ^CombatData) {
	combatData.target = int(skald.textboxCoreData.textboxes[0].positionCursor);
	combatData.turnUpdated = false;
}

//* Choose Attack
choose_attack :: proc(combatData: ^CombatData) {
	user:   ^monsters.Monster = combatData.timeline[combatData.turnPosition];
	target: ^monsters.Monster = &combatData.enemyMonsters[combatData.target];
	choice: int      = int(skald.textboxCoreData.textboxes[0].positionCursor);

	monsters.use_attack(user=user, target=target, moveIndex=choice);

	combatData.turnUpdated = false;
	combatData.target      = -1

	increment_turn(combatData);
}

//* Increment turn counter
increment_turn :: proc(combatData: ^CombatData) {
	if int(combatData.turnPosition + 1) > len(combatData.timeline) - 1 {
		combatData.turnPosition = 0;
		increment_round(combatData);
	} else {
		combatData.turnPosition += 1;
		combatData.turnUpdated   = false;
	}
}

//* Increment round counter
increment_round :: proc(combatData: ^CombatData) {
	combatData.roundPosition += 1;
	combatData.turnUpdated    = false;
	calculate_timeline(new(player.Player), combatData);
}