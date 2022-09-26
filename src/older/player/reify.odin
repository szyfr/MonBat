package player


//= Imports
import "core:fmt"
import "core:strings"

import "vendor:raylib"

import "../gamedata"


//= Procedures
//TODO: Load player from save data
init :: proc() {
	using gamedata

	gamedata.playerdata = new(PlayerData)

	//TODO: clear both monsters
}
free_data :: proc() {
	using gamedata

	free(gamedata.playerdata)
}