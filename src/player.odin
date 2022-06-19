package main



//= Imports

//= Constants

//= Global Variables
player: ^Player;


//= Structures
Player :: struct {
	monsters: [2]Monster,
};


//= Enumerations

//= Procedures
// TODO: loading from save
initialize_player :: proc() {
	player = new(Player);

	clear_monster(&player.monsters[0]);
	clear_monster(&player.monsters[1]);
}
free_player :: proc() {
	free(player);
}