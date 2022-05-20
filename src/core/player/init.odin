package player
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"


//= Player initialization
init :: proc() {
	player = new(Player);

	player.initialized     = true;

	player.camera.offset   = {0,0};
	player.camera.target   = {0,0};
	player.camera.rotation = 0;
	player.camera.zoom     = 1;
}