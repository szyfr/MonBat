package battle
///=-------------------=///
//  Written: 2022/05/20  //
//  Edited:  2022/05/20  //
///=-------------------=///



//import "core:fmt"
//import "core:strings"

import ray "../../raylib"
import ply "../player"


//= Initialize battle structure
init :: proc() {
	battle = new(Battle);

	battle.isActive = false;
	battle.player = ply.player;
}