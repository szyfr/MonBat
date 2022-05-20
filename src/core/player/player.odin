package player
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"
import mon "../monsters"


//= Global
player: ^Player;


//= Structs
Player :: struct {
	initialized: bool,

	camera: ray.Camera2d,

	monsters: [2]mon.Monster,
}