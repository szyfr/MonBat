package monsters


//= Import
import "../gamedata"


//= Constants
DEF_EXPERIENCE : u32 : 100

//= Procedures

//* Creation overloading
create_monster :: proc{ create_monster_ptr, create_monster_full, }

//* Create a monster using a pointer
create_monster_ptr :: proc(
	monster : ^gamedata.Monster,
	name    :  gamedata.MonsterNames,
	exp     :  u32  = DEF_EXPERIENCE,
	player  :  bool = false,
) {
	using gamedata
	
	monster.species    = name
	monster.player     = player
	monster.experience = exp

	#partial switch name {
		case .TEST_PIKACHU:
			monster.vitality = 20
			monster.mana     = 20

			monster.strength   = 10
			monster.magic      = 30

			monster.endurance  = 10
			monster.willpower  = 20

			monster.agility    = 40
			monster.luck       = 10

			append( &monster.attacks,
				MonsterAttacks.ThunderShock,
				MonsterAttacks.Growl,
			)
		case .TEST_WOOP:
			monster.vitality   = 30
			monster.mana       = 20

			monster.strength   = 30
			monster.magic      = 10

			monster.endurance  = 30
			monster.willpower  = 20

			monster.agility    = 20
			monster.luck       = 20

			append( &monster.attacks,
				MonsterAttacks.Tackle,
				MonsterAttacks.Growl,
			)
	}

	calculate_levelup(monster)
	calculate_health(monster)
	calculate_mana(monster)
}

create_monster_full :: proc(
	name    : gamedata.MonsterNames,
	exp     : u32  = DEF_EXPERIENCE,
	player  : bool = false,
) -> gamedata.Monster {
	monster : gamedata.Monster = {}

	create_monster(&monster, name, exp, player)

	return monster
}

destroy_monster :: proc(
	monster : ^gamedata.Monster,
) {
	delete(monster.attacks)
	free(monster)
}