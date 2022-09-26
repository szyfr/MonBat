package combat


//= Imports
import "../gamedata"


//= Procedures
init :: proc() {
	using gamedata

	combatdata = new(CombatData)
}

free_data :: proc() {
	using gamedata

	free(combatdata)
}