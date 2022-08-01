package monsters


//= Imports

//= Constants

//= Procedures

//* Monster attack
use_attack :: proc(user: ^Monster, target: ^Monster, moveIndex: int) {
	#partial switch user.attacks[moveIndex] {
		case .Tackle:
			target.healthCur -= 10;
			break;
		case .Growl:
			break;
		case .ThunderShock:
			target.healthCur -= 10;
			break;
	}

	if target.healthCur <= 0 {
		kill_monster(target);
	}
}