package graphics


//= Imports
import "vendor:raylib"

import "../gamedata"


//= Constants

//= Procedures
draw_battle_gui :: proc() {
	using raylib, gamedata

	//* Timeline
	DrawTexture(
		graphicsdata.timelineTexture,
		0, 32,
		raylib.WHITE,
	)
	// TODO: timeline positions

	//* Enemy monsters

	//* Player monsters

	//* GUI
}