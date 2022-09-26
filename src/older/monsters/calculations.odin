package monsters


//= Imports
import "core:math"

import "../gamedata"


//= Constants

//= Procedures

//* Health calculation
calculate_health :: proc(monster : ^gamedata.Monster) {
	total : u32 = (((2 * u32(monster.vitality)) * u32(monster.level)) / 100) + u32(monster.level) + 10

	monster.healthCur, monster.healthMax = total, total
}

//* Mana Calculation
calculate_mana :: proc(monster : ^gamedata.Monster) {
	total: u32 = (((2 * u32(monster.mana)) * u32(monster.level)) / 100) + u32(monster.level)

	monster.manaCur, monster.manaMax = total, total
}

//* Levelup calculation
calculate_levelup :: proc(monster : ^gamedata.Monster) {
	needed : u32 = u32(math.pow(f32(monster.level + 1), 3))

	if needed >= monster.experience {
		// TODO: add in stat changes
		monster.level += 1
		calculate_levelup(monster)
	}
}