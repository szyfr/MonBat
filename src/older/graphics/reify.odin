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

	graphicsdata = new(GraphicsData)

	//* Front monster textures
	for i:=0; i<len(graphicsdata.monster_frontTextures); i+=1 {
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
		graphicsdata.monster_frontTextures[i] = raylib.LoadTextureFromImage(img)

		//* Cleanup
		raylib.UnloadImage(img)
		delete(locationStr)
		delete(locationCStr)
		strings.reset_builder(&builder)
	}
	//* Back monster textures
	for i:=0; i<len(graphicsdata.monster_backTextures); i+=1 {
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
		graphicsdata.monster_backTextures[i] = raylib.LoadTextureFromImage(img)

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
	graphicsdata.timelineTexture = raylib.LoadTextureFromImage(img)
	raylib.UnloadImage(img)

	//* Timeline Icon
	img = raylib.LoadImage("data/battle/timeline_icon.png")
	raylib.ImageResizeNN(
		&img,
		img.width*IMAGE_SIZE_MULITPLIER,
		img.height*IMAGE_SIZE_MULITPLIER,
	)
	graphicsdata.timelineIconTexture = raylib.LoadTextureFromImage(img)
	raylib.UnloadImage(img)

	//* Textbox
	img = raylib.LoadImage("data/battle/textbox.png")
	raylib.ImageResizeNN(
		&img,
		img.width*IMAGE_SIZE_MULITPLIER,
		img.height*IMAGE_SIZE_MULITPLIER,
	)
	graphicsdata.textboxTexture = raylib.LoadTextureFromImage(img)
	raylib.UnloadImage(img)

	width:  f32 = f32(graphicsdata.textboxTexture.width)
	height: f32 = f32(graphicsdata.textboxTexture.height)

	graphicsdata.textboxNPatch = {};
	graphicsdata.textboxNPatch.source = raylib.Rectangle{0, 0, width, height}
	graphicsdata.textboxNPatch.left   = i32(width)  / 3
	graphicsdata.textboxNPatch.top    = i32(height) / 3
	graphicsdata.textboxNPatch.right  = i32(width)  / 3
	graphicsdata.textboxNPatch.bottom = i32(height) / 3
	graphicsdata.textboxNPatch.layout = .NINE_PATCH

	//* Font
	graphicsdata.font = raylib.LoadFont("data/fonts/kong.ttf");
}
free_data :: proc() {
	using gamedata

	//* Front and back textures
	for i:=0; i<len(graphicsdata.monster_backTextures); i+=1 {
		raylib.UnloadTexture(graphicsdata.monster_backTextures[i])
		raylib.UnloadTexture(graphicsdata.monster_frontTextures[i])
	}
	//* Timeline
	raylib.UnloadTexture(graphicsdata.timelineTexture)
	raylib.UnloadTexture(graphicsdata.timelineIconTexture)
	//* Textbox
	raylib.UnloadTexture(graphicsdata.textboxTexture)
	raylib.UnloadFont(graphicsdata.font)

	free(graphicsdata);
}