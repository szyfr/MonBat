package textbox
///=-------------------=///
//  Written: 2022/05/28  //
//  Edited:  2022/05/28  //
///=-------------------=///



import fmt "core:fmt"
import str "core:strings"

import ray "../../raylib"


//= Global
@(private)
textboxData: TextboxData;


//= Enumerations
TextboxFlags     :: enum {}
TextboxFlags_Set :: bit_set[TextboxFlags]

TextboxType      :: enum { normal, menu, }


//= Structs
@(private)
TextboxData :: struct {
	texture:   ray.Texture,
	nPatch:    ray.N_Patch_Info,
	font:      ray.Font,
	cursor:    ray.Texture,

	textSpeed: u32,

	textboxes: [dynamic]Textbox,
}

@(private)
Textbox :: struct {
	position: ray.Vector2,
	size:     ray.Vector2,
	type:     TextboxType,

	// TextboxType.normal
	text:     [dynamic]string,
	// TextboxType.menu
	options:  [dynamic]MenuOptions,
	cursor:   u32,

	// For timing and interaction
	canBeClicked: bool,
	displayChar:  u32,
	displayLine:  u32,
}

MenuOptions :: struct {
	position: ray.Vector2,
	text:     string,
	effect:   proc(),
}



//= Constants


//= Procedures
// TODO: create error checking procedure for initialization to check in detail

//- Initialization
// Initialize textbox data with a very basic gray bg and current font
@(private)
init_textbox_none :: proc(value: u8) -> u32 {
	// Texture
	image: ray.Image    = ray.gen_image_color(3, 3, ray.GRAY);
	textboxData.texture = ray.load_texture_from_image(image);
	ray.unload_image(image);

	// NPatch
	textboxData.nPatch = {};
	textboxData.nPatch.source = ray.Rectangle{0,0,3,3};
	textboxData.nPatch.left   = 1;
	textboxData.nPatch.top    = 1;
	textboxData.nPatch.right  = 1;
	textboxData.nPatch.bottom = 1;
	textboxData.nPatch.layout = i32(ray.N_Patch_Layout.NPATCH_NINE_PATCH);

	// Font
	textboxData.font = ray.get_font_default();

	// Textboxes
	textboxData.textboxes = make([dynamic]Textbox);

	// Checking
	if textboxData.texture == {} do return 1;
	if textboxData.nPatch  == {} do return 2;
	if textboxData.font    == {} do return 3;

	return 0;
}
// Initialize textbox data with inputs
@(private)
init_textbox_input :: proc(texture: ray.Texture = {}, npatch: ray.N_Patch_Info = {}, font: ray.Font = {}) -> u32 {
	// Texture
	if texture == {} {
		image: ray.Image    = ray.gen_image_color(3, 3, ray.GRAY);
		textboxData.texture = ray.load_texture_from_image(image);
	} else do textboxData.texture = texture;

	// NPatch
	if npatch == {} {
		textboxData.nPatch = {};
		textboxData.nPatch.source = ray.Rectangle{0,0,3,3};
		textboxData.nPatch.left   = 1;
		textboxData.nPatch.top    = 1;
		textboxData.nPatch.right  = 1;
		textboxData.nPatch.bottom = 1;
		textboxData.nPatch.layout = i32(ray.N_Patch_Layout.NPATCH_NINE_PATCH);
	} else do textboxData.nPatch = npatch;

	// Font
	if font == {} do textboxData.font = ray.get_font_default();
	else          do textboxData.font = font;

	// Textboxes
	textboxData.textboxes = make([dynamic]Textbox);

	// Checking
	if textboxData.texture == {} do return 1;
	if textboxData.nPatch  == {} do return 2;
	if textboxData.font    == {} do return 3;

	return 0;
}
// Initialization overloading
init_textbox :: proc {init_textbox_none, init_textbox_input}


//- Creating boxes
// Creates a textbox
create_textbox :: proc(position: ray.Vector2 = {0,0}, size: ray.Vector2 = {10,10}, text: [dynamic]string = nil) -> u32 {
	newBox: Textbox     = {};
	newBox.position     = position;
	newBox.size         = size;
	newBox.type         = TextboxType.normal;
	newBox.canBeClicked = false;
	newBox.displayChar  = 0;
	newBox.displayLine  = 0;

	// Unused values
	newBox.options = nil;
	newBox.cursor  = 0;

	// Text
	if text == nil do newBox.text = make([dynamic]string);
	else           do newBox.text = text;

	// Checking
	// TODO:

	append(&textboxData.textboxes, newBox);
	return 0;
}
// Creates a menu
create_menu :: proc(position: ray.Vector2 = {0,0}, size: ray.Vector2 = {10,10}, options: [dynamic]MenuOptions = nil) -> u32 {
	newBox: Textbox     = {};
	newBox.position     = position;
	newBox.size         = size;
	newBox.type         = TextboxType.menu;
	newBox.canBeClicked = false;
	newBox.displayChar  = 0;
	newBox.displayLine  = 0;
	
	// Unused values
	newBox.text = nil;

	// Menu options
	if options == nil do newBox.options = make([dynamic]MenuOptions);
	else              do newBox.options = options;
	newBox.cursor  = 0;

	// Checking
	// TODO:
	
	append(&textboxData.textboxes, newBox);
	return 0;
}


//- 
//
update_textboxes :: proc() {

}
//
draw_textboxes :: proc() {
	for i:=0; i < len(textboxData.textboxes); i+=1 {
		position: ray.Vector2 = textboxData.textboxes[i].position;
		size: ray.Vector2     = textboxData.textboxes[i].size;

		ray.draw_texture_n_patch(
			textboxData.texture,
			textboxData.nPatch,
			ray.Rectangle{position.x, position.y, size.x, size.y},
			ray.Vector2{0,0},
			0, ray.WHITE);
		ray.draw_text(
			textboxData.textboxes[i].text[textboxData.textboxes[i].displayLine],
			//TODO: text
			);
	}
}