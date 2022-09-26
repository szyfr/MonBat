package gamedata


//= Imports
import "../gamedata"


//= Structures
CombatData :: struct{
	active : bool,

	enemyMonsters  : [dynamic]gamedata.Monster,
	playerMonsters : [dynamic]gamedata.Monster,
}