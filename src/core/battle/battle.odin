package battle
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"
import mon "../monsters"
import ply "../player"


//= Global
battle: ^Battle;


//= Structs
Battle :: struct {
	isActive: bool,

	player: ^ply.Player,
	monsters: [dynamic]mon.Monster,

	timeline: [dynamic]^mon.Monster,
}