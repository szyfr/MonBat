package monsters


//= Imports

//= Constants
DEFAULT_EXPERIENCE : u32 : 100


//= Procedures

//* Create Overloading
create_monster      :: proc{ create_monster_ptr, create_monster_full, }

//* Create monster pointer
create_monster_ptr  :: proc(
		monster : ^Monster,
		name    :  MonsterNames,
		exp     :  u32   = DEFAULT_EXPERIENCE,
		player  :  bool  = false) {
	
	monster.species     = name;
	monster.initialized = true;

	if player do monster.playerOwned = true;

	monster.experience = exp;
	calculate_levelup(monster);

	#partial switch name {
		case .TEST_PIKACHU:
			monster.vitality   = 20;
			monster.mana       = 20;

			monster.strength   = 10;
			monster.magic      = 30;

			monster.endurance  = 10;
			monster.willpower  = 20;

			monster.agility    = 40;
			monster.luck       = 10;

			append(&monster.attacks, MonsterAttacks.ThunderShock, MonsterAttacks.Growl);
			break;
		case .TEST_WOOP:
			monster.vitality   = 30;
			monster.mana       = 20;

			monster.strength   = 30;
			monster.magic      = 10;

			monster.endurance  = 30;
			monster.willpower  = 20;

			monster.agility    = 20;
			monster.luck       = 20;

			append(&monster.attacks, MonsterAttacks.Tackle, MonsterAttacks.Growl);
			break;
	}

	calculate_health(monster);
	calculate_mana(monster);
}

//* Create monster Structure
create_monster_full :: proc(
		name   : MonsterNames,
		exp    : u32  = 100,
		player : bool = false,
		) -> Monster {
	
	monster: Monster = {};

	clear_monster(&monster);
	create_monster(&monster, name, exp, player);

	return monster;
}

//* Clearing monster
clear_monster       :: proc(monster: ^Monster) {
	monster.species = .empty;

	monster.healthCur  = 0;
	monster.healthMax  = 0;
	monster.manaCur    = 0;
	monster.manaMax    = 0;
	monster.level      = 0;
	monster.experience = 0;
	monster.vitality   = 0;
	monster.mana       = 0;
	monster.strength   = 0;
	monster.magic      = 0;
	monster.endurance  = 0;
	monster.willpower  = 0;
	monster.agility    = 0;
	monster.luck       = 0;

	delete(monster.attacks);
	monster.attacks = make([dynamic]MonsterAttacks);
}

//* Kill monster
// TODO: Figure out what to do with this
kill_monster        :: proc(monster: ^Monster) {
//	temp: int = 0;
//
//	for i:=0; i<len(battleStructure.enemyMonsters); i+=1 {
//		if compare_monsters(&battleStructure.enemyMonsters[i], monster) do break;
//	}
//
//	//TODO: replace this with and actual deletion. 
//	clear_monster(&battleStructure.enemyMonsters[temp]);
//	calculate_timeline();
}