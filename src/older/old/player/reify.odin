package player


//= Imports
import "../monsters"


//= Constants

//= Procedures

//* Reification of Player
// TODO: Load from save
init :: proc() -> ^Player {
	player := new(Player)

	monsters.clear_monster(&player.playerMonsters[0]);
	monsters.clear_monster(&player.playerMonsters[1]);

	return player
}
free :: proc(player: ^Player) {
	free(player);
}