package gamedata


//= Imports
import "vendor:raylib"


//= Structures
GraphicsData :: struct {
	monster_frontTextures : [len(MonsterNames)]raylib.Texture,
	monster_backTextures  : [len(MonsterNames)]raylib.Texture,

	timelineTexture       : raylib.Texture,
	timelineIconTexture   : raylib.Texture,

	textboxTexture        : raylib.Texture,
	textboxNPatch         : raylib.NPatchInfo,

	font                  : raylib.Font,
}