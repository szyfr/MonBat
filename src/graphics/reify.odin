package graphics


//= Imports
import "core:fmt"
import "core:strings"

import "vendor:raylib"

import "../gamedata"


//= Constants
IMAGE_SIZE_MULITPLIER : i32 : 2


//= Procedures
init :: proc() {
	using raylib, gamedata

	gamedata.graphicsdata = new(GraphicsData)

	//* Front monster textures
	for i:=0; i<len(gamedata.graphicsdata.monster_frontTextures); i+=1 {
		//* Generate name
		builder: strings.Builder;
		locationStr  : string  = fmt.sbprintf(&builder, "data/battle/FRONT_%i.png", i)
		locationCStr : cstring = strings.clone_to_cstring(locationStr)

		//* Load texture
		img : raylib.Image = raylib.LoadImage(locationCStr)
		raylib.ImageResizeNN(
			&img,
			img.width*IMAGE_SIZE_MULITPLIER,
			img.height*IMAGE_SIZE_MULITPLIER,
		)
		gamedata.graphicsdata.monster_frontTextures[i] = raylib.LoadTextureFromImage(img)

		//* Cleanup
		raylib.UnloadImage(img)
		delete(locationStr)
		delete(locationCStr)
		strings.reset_builder(&builder)
	}
	//* Back monster textures
	for i:=0; i<len(gamedata.graphicsdata.monster_backTextures); i+=1 {
		//* Generate name
		builder: strings.Builder;
		locationStr  : string  = fmt.sbprintf(&builder, "data/battle/BACK_%i.png", i)
		locationCStr : cstring = strings.clone_to_cstring(locationStr)

		//* Load texture
		img : raylib.Image = raylib.LoadImage(locationCStr)
		raylib.ImageResizeNN(
			&img,
			img.width*IMAGE_SIZE_MULITPLIER,
			img.height*IMAGE_SIZE_MULITPLIER,
		)
		gamedata.graphicsdata.monster_backTextures[i] = raylib.LoadTextureFromImage(img)

		//* Cleanup
		raylib.UnloadImage(img)
		delete(locationStr)
		delete(locationCStr)
		strings.reset_builder(&builder)
	}

	img : raylib.Image

	//* Timeline
	img = raylib.LoadImage("data/battle/timeline.png")
	raylib.ImageResizeNN(
		&img,
		img.width*IMAGE_SIZE_MULITPLIER,
		img.height*IMAGE_SIZE_MULITPLIER,
	)
	gamedata.graphicsdata.timelineTexture = raylib.LoadTextureFromImage(img)
	raylib.UnloadImage(img)

	//* Timeline Icon
	img = raylib.LoadImage("data/battle/timeline_icon.png")
	raylib.ImageResizeNN(
		&img,
		img.width*IMAGE_SIZE_MULITPLIER,
		img.height*IMAGE_SIZE_MULITPLIER,
	)
	gamedata.graphicsdata.timelineIconTexture = raylib.LoadTextureFromImage(img)
	raylib.UnloadImage(img)

	//* Textbox
	img = raylib.LoadImage("data/battle/textbox.png")
	raylib.ImageResizeNN(
		&img,
		img.width*IMAGE_SIZE_MULITPLIER,
		img.height*IMAGE_SIZE_MULITPLIER,
	)
	gamedata.graphicsdata.textboxTexture = raylib.LoadTextureFromImage(img)
	raylib.UnloadImage(img)

	width:  f32 = f32(gamedata.graphicsdata.textboxTexture.width)
	height: f32 = f32(gamedata.graphicsdata.textboxTexture.height)

	gamedata.graphicsdata.textboxNPatch = {};
	gamedata.graphicsdata.textboxNPatch.source = raylib.Rectangle{0, 0, width, height}
	gamedata.graphicsdata.textboxNPatch.left   = i32(width)  / 3
	gamedata.graphicsdata.textboxNPatch.top    = i32(height) / 3
	gamedata.graphicsdata.textboxNPatch.right  = i32(width)  / 3
	gamedata.graphicsdata.textboxNPatch.bottom = i32(height) / 3
	gamedata.graphicsdata.textboxNPatch.layout = .NINE_PATCH

	//* Font
	gamedata.graphicsdata.font = raylib.LoadFont("data/fonts/kong.ttf");
}
free_data :: proc() {
	using gamedata

	//* Front and back textures
	for i:=0; i<len(gamedata.graphicsdata.monster_backTextures); i+=1 {
		raylib.UnloadTexture(gamedata.graphicsdata.monster_backTextures[i])
		raylib.UnloadTexture(gamedata.graphicsdata.monster_frontTextures[i])
	}
	//* Timeline
	raylib.UnloadTexture(gamedata.graphicsdata.timelineTexture)
	raylib.UnloadTexture(gamedata.graphicsdata.timelineIconTexture)
	//* Textbox
	raylib.UnloadTexture(gamedata.graphicsdata.textboxTexture)
	raylib.UnloadFont(gamedata.graphicsdata.font)

	free(gamedata.graphicsdata);
}