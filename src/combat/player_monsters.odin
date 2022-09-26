package combat


//= Imports
import "../combat"
import "../gamedata"
import "../monsters"


//= Constants

//= Procedures
generate_player_WOOP :: proc() {
	using gamedata

	append( &combatdata.playerMonsters,
		monsters.create_monster(
			name   = .TEST_WOOP,
			exp    = 1000,
			player = true,
		),
	)
}