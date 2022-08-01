package combat


//= Imports
import "../skald"
import "../raylib"

import "../monsters"
import "../player"


//= Constants

//= Procedures

//* Logic
update_battle :: proc(combatData: ^CombatData) {
	if !combatData.turnUpdated {
		combatData.turnUpdated = true;

		if combatData.timeline[combatData.turnPosition].playerOwned {
			// player turn
			// TODO: make it able to go back to target selection
			if combatData.target == 5 {
				combatData.target = 5;
				user: ^monsters.Monster = combatData.timeline[combatData.turnPosition];

				options: [dynamic]skald.MenuOption;
				str:     [dynamic]string = get_enemy_list(combatData);

				for i:=0; i<len(str); i+=1 {
					append(&options, skald.MenuOption{str[i], choose_target});
				}

				skald.create_textbox(
					textboxRect=raylib.Rectangle{0, 460, 1280, 260},
					optionsRect={980,460,300,100},
					fontSize=16,
					offset={32,32},
					textSingle="Choose target",
					options=options);
			} else {
				options: [dynamic]skald.MenuOption;
				str:     [dynamic]string = get_monster_attack_list(combatData.timeline[combatData.turnPosition]);

				for i:=0; i<len(str); i+=1 {
					append(&options, skald.MenuOption{str[i], choose_attack})
				}

				skald.create_textbox(
					textboxRect=raylib.Rectangle{0, 460, 1280, 260},
					fontSize=16,
					textSingle="Choose attack",
					options=options);
			}
			
		} else {
			// AI turn
		}
	}
}

//* Draw
render_battle :: proc(combatData: ^CombatData) {
	if combatData.isActive {
		// Timeline
		raylib.draw_texture(graphicsStorage.timelineTexture, 0, 32, raylib.WHITE);

		// Calculate min/max

		for i:=0; i<len(combatData.timeline); i+=1 {
			if combatData.timeline[i].species != .empty {
				color: raylib.Color;
				if combatData.timeline[i].playerOwned do color = raylib.GREEN;
				else                                       do color = raylib.RED;

				position: f32 = (f32(i) / f32(len(combatData.timeline) - 1));
				offset:   f32 = -f32((f32(combatData.turnPosition) / f32(len(combatData.timeline)-1)) * 568);

				raylib.draw_texture(graphicsStorage.timelineIcon, i32(position * 568) + 50 + i32(offset), 0, color);
			}
		}
		
		// Enemy monsters
		for i:=0; i < len(combatData.enemyMonsters); i+=1 {
			if combatData.enemyMonsters[i].species != .empty {
				monster: ^Monster = &combatData.enemyMonsters[i];
				monsterIndex: int = get_monster_texture_index(monster);

				raylib.draw_texture(
					graphicsStorage.monster_frontTextures[monsterIndex],
					screen_width - 200 - (i32(i) * 150), 96,
					raylib.WHITE);

				raylib.draw_text_ex(
					graphicsStorage.font,
					get_monster_name(monster),
					raylib.Vector2{f32(screen_width) - 200 - (f32(i) * 150), 224},
					16, 1, raylib.BLACK);
				raylib.draw_text_ex(
					graphicsStorage.font,
					get_monster_health_ratio(monster),
					raylib.Vector2{f32(screen_width) - 200 - (f32(i) * 150), 240},
					16, 1, raylib.BLACK);
			}
		}

		// Player Monsters
		// 1
		index  := get_monster_texture_index(&player.monsters[0]);
		height := graphicsStorage.monster_backTextures[index].height;

		raylib.draw_texture(
			graphicsStorage.monster_backTextures[index],
			100, 96 + height + 64,
			raylib.WHITE);
		raylib.draw_text_ex(
			graphicsStorage.font,
			get_monster_name(&player.monsters[0]),
			raylib.Vector2{100, 256},
			16, 1, raylib.BLACK);
		raylib.draw_text_ex(
			graphicsStorage.font,
			get_monster_health_ratio(&player.monsters[0]),
			raylib.Vector2{100, 272},
			16, 1, raylib.BLACK);

		index = get_monster_texture_index(&player.monsters[1]);
		raylib.draw_texture(
			graphicsStorage.monster_backTextures[index],
			250, 96 + height + 64,
			raylib.WHITE);
		raylib.draw_text_ex(
			graphicsStorage.font,
			get_monster_name(&player.monsters[1]),
			raylib.Vector2{250, 256},
			16, 1, raylib.BLACK);
		raylib.draw_text_ex(
			graphicsStorage.font,
			get_monster_health_ratio(&player.monsters[1]),
			raylib.Vector2{250, 272},
			16, 1, raylib.BLACK);
	}
}