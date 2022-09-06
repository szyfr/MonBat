package monsters


//= Imports
import "core:math"


//= Constants

//= Procedures

//* Health / Mana
calculate_health  :: proc(monster: ^Monster) {
	total: i32 = (((2 * i32(monster.vitality)) * i32(monster.level)) / 100) + i32(monster.level) + 10;

	monster.healthCur, monster.healthMax = total, total;
}
calculate_mana    :: proc(monster: ^Monster) {
	total: i32 = (((2 * i32(monster.mana)) * i32(monster.level)) / 100) + i32(monster.level);

	monster.manaCur, monster.manaMax = total, total;
}

//* Experience / Levelup
calculate_exp     :: proc(monster: ^Monster) {
	needed: u32 = u32(math.pow(f32(monster.level + 1), 3));

	if needed >= monster.experience {
		calculate_levelup(monster);
		calculate_exp(monster);
	}
}
calculate_levelup :: proc(monster: ^Monster) {
	// TODO:
	monster.level += 1;
}