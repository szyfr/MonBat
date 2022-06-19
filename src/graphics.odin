package main



//= Imports
import "core:fmt"
import "core:strings"
import "raylib"

//= Constants

//= Global Variables
graphicsStorage: ^GraphicsStorage;


//= Structures
GraphicsStorage :: struct {
	monster_frontTextures: [MonsterNames.SIZE]raylib.Texture,
	monster_backTextures:  [MonsterNames.SIZE]raylib.Texture,

	timelineTexture: raylib.Texture,

	textboxTexture: raylib.Texture,
	textboxNPatch:  raylib.N_Patch_Info,
}


//= Enumerations

//= Procedures
//- Initialization / Freeing
initialize_graphics :: proc(multiplier: i32) {
	graphicsStorage = new(GraphicsStorage);

	// Monster front textures
	for i:=0; i < len(graphicsStorage.monster_frontTextures); i+=1 {
		builder: strings.Builder;
		locationStr:  string  = fmt.sbprintf(&builder, "data/battle/FRONT_%i.png", i);
		locationCStr: cstring = strings.clone_to_cstring(locationStr);

		img: raylib.Image = raylib.load_image(locationCStr);
		raylib.image_resize_nn(&img, img.width * multiplier, img.height * multiplier);
		graphicsStorage.monster_frontTextures[i] = raylib.load_texture_from_image(img);

		raylib.unload_image(img);
		delete(locationStr);
		delete(locationCStr);
		strings.reset_builder(&builder);
	}
	// Monster back textures
	for i:=0; i < len(graphicsStorage.monster_backTextures); i+=1 {
		builder: strings.Builder;
		locationStr:  string  = fmt.sbprintf(&builder, "data/battle/BACK_%i.png", i);
		locationCStr: cstring = strings.clone_to_cstring(locationStr);

		img: raylib.Image = raylib.load_image(locationCStr);
		raylib.image_resize_nn(&img, img.width * multiplier, img.height * multiplier);
		graphicsStorage.monster_backTextures[i] = raylib.load_texture_from_image(img);

		raylib.unload_image(img);
		delete(locationStr);
		delete(locationCStr);
		strings.reset_builder(&builder);
	}

	img: raylib.Image;

	// Timeline
	img = raylib.load_image("data/battle/timeline.png");
	raylib.image_resize_nn(&img, img.width * multiplier, img.height * multiplier);
	graphicsStorage.timelineTexture = raylib.load_texture_from_image(img);
	raylib.unload_image(img);

	// Textbox
	img = raylib.load_image("data/battle/textbox.png");
	raylib.image_resize_nn(&img, img.width * multiplier, img.height * multiplier);
	graphicsStorage.textboxTexture = raylib.load_texture_from_image(img);
	raylib.unload_image(img);

	width:  f32 = f32(graphicsStorage.textboxTexture.width);
	height: f32 = f32(graphicsStorage.textboxTexture.height);

	graphicsStorage.textboxNPatch = {};
	graphicsStorage.textboxNPatch.source = raylib.Rectangle{0, 0, width, height};
	graphicsStorage.textboxNPatch.left   = i32(width)  / 3;
	graphicsStorage.textboxNPatch.top    = i32(height) / 3;
	graphicsStorage.textboxNPatch.right  = i32(width)  / 3;
	graphicsStorage.textboxNPatch.bottom = i32(height) / 3;
	graphicsStorage.textboxNPatch.layout = i32(raylib.N_Patch_Layout.NPATCH_NINE_PATCH);
}
free_graphics :: proc() {
	for i:=0; i < int(MonsterNames.SIZE); i+=1 {
		raylib.unload_texture(graphicsStorage.monster_backTextures[i]);
		raylib.unload_texture(graphicsStorage.monster_frontTextures[i]);
	}
	raylib.unload_texture(graphicsStorage.timelineTexture);
	raylib.unload_texture(graphicsStorage.textboxTexture);

	free(graphicsStorage);
}