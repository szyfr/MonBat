package player
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/23  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"
import mon "../monsters"


//= Global
player: ^Player;


//= Structs
Player :: struct {
	camera: ray.Camera2d,

	monsters: [2]mon.Monster,
}


//= Procedures

// Player Initialization
init :: proc() {
	player = new(Player);

	// Camera settings
	player.camera.offset   = {0,0};
	player.camera.target   = {0,0};
	player.camera.rotation = 0;
	player.camera.zoom     = 1;

	// Monster team
	mon.clear(&player.monsters[0]);
	mon.clear(&player.monsters[1]);
}