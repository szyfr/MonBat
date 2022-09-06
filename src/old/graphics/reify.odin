package graphics


//= Imports
import "core:fmt"
import "core:strings"

import "../raylib"

import "../monsters"


//= Constants
IMAGE_SIZE_MULITPLIER : i32 : 2


//= Procedures

//* Reification of Graphics
init :: proc() -> ^GraphicsData {
	graphicsData := new(GraphicsData)

	//* Monster Front Textures
	for i:=0; i<len(graphicsData.monster_frontTextures); i+=1 {
		builder: strings.Builder;
		locationStr  : string  = fmt.sbprintf(&builder, "data/battle/FRONT_%i.png", i)
		locationCStr : cstring = strings.clone_to_cstring(locationStr)

		img : raylib.Image = raylib.load_image(locationCStr)
		raylib.image_resize_nn(
			&img,
			img.width*IMAGE_SIZE_MULITPLIER,
			img.height*IMAGE_SIZE_MULITPLIER,
		)
		graphicsData.monster_frontTextures[i] = raylib.load_texture_from_image(img)

		raylib.unload_image(img)
		delete(locationStr)
		delete(locationCStr)
		strings.reset_builder(&builder)
	}
	//* Monster Back Textures
	for i:=0; i<len(graphicsData.monster_backTextures); i+=1 {
		builder: strings.Builder;
		locationStr  : string  = fmt.sbprintf(&builder, "data/battle/BACK_%i.png", i)
		locationCStr : cstring = strings.clone_to_cstring(locationStr)

		img : raylib.Image = raylib.load_image(locationCStr)
		raylib.image_resize_nn(
			&img,
			img.width*IMAGE_SIZE_MULITPLIER,
			img.height*IMAGE_SIZE_MULITPLIER,
		)
		graphicsData.monster_backTextures[i] = raylib.load_texture_from_image(img)

		raylib.unload_image(img)
		delete(locationStr)
		delete(locationCStr)
		strings.reset_builder(&builder)
	}

	img : raylib.Image

	//* Timeline
	img = raylib.load_image("data/battle/timeline.png")
	raylib.image_resize_nn(
		&img,
		img.width*IMAGE_SIZE_MULITPLIER,
		img.height*IMAGE_SIZE_MULITPLIER,
	)
	graphicsData.timelineTexture = raylib.load_texture_from_image(img)
	raylib.unload_image(img)

	//* Timeline Icon
	img = raylib.load_image("data/battle/timeline_icon.png")
	raylib.image_resize_nn(
		&img,
		img.width*IMAGE_SIZE_MULITPLIER,
		img.height*IMAGE_SIZE_MULITPLIER,
	)
	graphicsData.timelineIconTexture = raylib.load_texture_from_image(img)
	raylib.unload_image(img)

	//* Textbox
	img = raylib.load_image("data/battle/textbox.png")
	raylib.image_resize_nn(
		&img,
		img.width*IMAGE_SIZE_MULITPLIER,
		img.height*IMAGE_SIZE_MULITPLIER,
	)
	graphicsData.textboxTexture = raylib.load_texture_from_image(img)
	raylib.unload_image(img)

	width:  f32 = f32(graphicsData.textboxTexture.width)
	height: f32 = f32(graphicsData.textboxTexture.height)

	graphicsData.textboxNPatch = {};
	graphicsData.textboxNPatch.source = raylib.Rectangle{0, 0, width, height}
	graphicsData.textboxNPatch.left   = i32(width)  / 3
	graphicsData.textboxNPatch.top    = i32(height) / 3
	graphicsData.textboxNPatch.right  = i32(width)  / 3
	graphicsData.textboxNPatch.bottom = i32(height) / 3
	graphicsData.textboxNPatch.layout = i32(raylib.N_Patch_Layout.NPATCH_NINE_PATCH)

	//* Font
	graphicsData.font = raylib.load_font("data/fonts/kong.ttf");

	return graphicsData
}
free :: proc(graphicsData: ^GraphicsData) {
	//* Front and back textures
	for i:=0; i<int(monsters.MonsterNames.SIZE); i+=1 {
		raylib.unload_texture(graphicsData.monster_backTextures[i])
		raylib.unload_texture(graphicsData.monster_frontTextures[i])
	}
	//* Timeline
	raylib.unload_texture(graphicsData.timelineTexture)
	raylib.unload_texture(graphicsData.timelineIconTexture)
	//* Textbox
	raylib.unload_texture(graphicsData.textboxTexture)
	raylib.unload_font(graphicsData.font)

	free(graphicsData);
}