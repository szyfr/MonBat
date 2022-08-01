package graphics


//= Imports
import "../raylib"

import "../monsters"


//= Constants

//= Structures
GraphicsData :: struct {
	monster_frontTextures : [monsters.MonsterNames.SIZE]raylib.Texture,
	monster_backTextures  : [monsters.MonsterNames.SIZE]raylib.Texture,

	timelineTexture       : raylib.Texture,
	timelineIconTexture   : raylib.Texture,

	textboxTexture        : raylib.Texture,
	textboxNPatch         : raylib.N_Patch_Info,

	font                  : raylib.Font,
}


//= Enumerations
