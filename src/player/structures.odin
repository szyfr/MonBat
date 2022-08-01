package player


//= Imports
//import "../main"
import "../monsters"


//= Constants

//= Structures
Player :: struct {
	playerMonsters: [2]monsters.Monster,
}


//= Enumerations

//= Procedures
// TODO: Load from save
//* Initialize / Free Player
init :: proc() -> ^Player {
	player := new(Player)

	return player
}
free :: proc(player: ^Player) {
	free(player);
}