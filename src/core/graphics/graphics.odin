package graphics
///=-------------------=///
//  Written: 2022/05/23  //
//  Edited:  2022/05/23  //
///=-------------------=///



import fmt "core:fmt"
import str "core:strings"

import ray "../../raylib"


//= Constants
IMAGE_IMPORT_MULTIPLIER :: 4


//= Enumerations
MonsterTextures :: enum { Empty, TEST_PIKACHU, TEST_WOOP, SIZE, };


//= Global
graphics: ^Graphics;


//= Structs
Graphics :: struct {
	monsterFrontTextures: [MonsterTextures.SIZE]ray.Texture,
	monsterBackTextures:  [MonsterTextures.SIZE]ray.Texture,
	textboxTexture:       ray.Texture,
	textboxNPatch:        ray.N_Patch_Info,
};


//= Procedures

// Initialize graphics
init :: proc() {
	graphics = new(Graphics);

	// Front monster
	for i:=0; i < len(graphics.monsterFrontTextures); i+=1 {
		builder: str.Builder = {};
		sstr:    string      = fmt.sbprintf(&builder, "data/battle/FRONT_%i.png", i);
		cstr:    cstring     = str.clone_to_cstring(sstr);

		img: ray.Image = ray.load_image(cstr);
		ray.image_resize_nn(&img, img.width * IMAGE_IMPORT_MULTIPLIER, img.height * IMAGE_IMPORT_MULTIPLIER);
		graphics.monsterFrontTextures[i] = ray.load_texture_from_image(img);

		ray.unload_image(img);
		delete(sstr);
		delete(cstr);
	}

	// Back monster
	for i:=0; i < len(graphics.monsterBackTextures); i+=1 {
		builder: str.Builder = {};
		sstr:    string      = fmt.sbprintf(&builder, "data/battle/BACK_%i.png", i);
		cstr:    cstring     = str.clone_to_cstring(sstr);

		img: ray.Image = ray.load_image(cstr);
		ray.image_resize_nn(&img, img.width * IMAGE_IMPORT_MULTIPLIER, img.height * IMAGE_IMPORT_MULTIPLIER);
		graphics.monsterBackTextures[i] = ray.load_texture_from_image(img);

		ray.unload_image(img);
		delete(sstr);
		delete(cstr);
	}

	// Textbox
	//Texture
	img: ray.Image = ray.load_image("data/battle/textbox.png");
	ray.image_resize_nn(&img, img.width * IMAGE_IMPORT_MULTIPLIER, img.height * IMAGE_IMPORT_MULTIPLIER);
	graphics.textboxTexture = ray.load_texture_from_image(img);
	ray.unload_image(img);
	//NPatch
	graphics.textboxNPatch = {};
	graphics.textboxNPatch.source = ray.Rectangle{0,0,96,96};
	graphics.textboxNPatch.left   = 32;
	graphics.textboxNPatch.top    = 32;
	graphics.textboxNPatch.right  = 32;
	graphics.textboxNPatch.bottom = 32;
	graphics.textboxNPatch.layout = i32(ray.N_Patch_Layout.NPATCH_NINE_PATCH);
}