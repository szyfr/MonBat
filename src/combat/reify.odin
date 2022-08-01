package combat


//= Imports
import "../monsters"


//= Constants

//= Procedures

//* Reification of CombatData
init :: proc() -> ^CombatData {
	combatData := new(CombatData)

	combatData.isActive      = false

	combatData.enemyMonsters = make([dynamic]monsters.Monster)
	combatData.timeline      = make([dynamic]^monsters.Monster)

	combatData.turnPosition  = 0
	combatData.roundPosition = 0

	combatData.turnUpdated   = false
	combatData.target        = -1

	return combatData
}
free :: proc(combatData: ^CombatData) {
	delete(combatData.enemyMonsters)
	delete(combatData.timeline)

	free(combatData)
}