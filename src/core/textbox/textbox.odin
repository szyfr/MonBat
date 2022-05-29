package textbox
///=-------------------=///
//  Written: 2022/05/28  //
//  Edited:  2022/05/28  //
///=-------------------=///



import fmt "core:fmt"
import str "core:strings"

import ray "../../raylib"


//= Global


//= Enumerations
TextboxFlags     :: enum{}
TextboxFlags_Set :: bit_set[TextboxFlags]


//= Structs
TextboxStatus  :: struct {
	isActive:       bool,
	cursorPosition: int,
}

TextboxOptions :: struct {
	text: [dynamic]string,
	use:  [dynamic]proc(),
}

TextboxData    :: struct {
	textboxTexture: ray.Texture,
	textboxNPatch:  ray.N_Patch_Info,
}


//= Constants


//= Procedures

//
create_textbox :: proc(location: ray.Vector2, text: [dynamic]string, flags: TextboxFlags_Set) {

}

// 
create_menubox :: proc(location: ray.Vector2, options: [dynamic]TextboxOptions, flags: TextboxFlags_Set) {

}