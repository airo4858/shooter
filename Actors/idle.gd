extends State

var detect_range : Area2D
var shoot_range : Area2D
var chasing_state : State
var shooting_state : State

func initialize():
	detect_range = body.get_node("DetectionRange")
	shoot_range = body.get_node("ShootRange")
	chasing_state = get_parent().get_node("Chasing")
	#shooting_state = get_parent().get_node("Shooting")
	
func process_state(delta: float):
	var potential_targets = detect_range.get_overlapping_bodies()
	#var shoot_targets = shoot_range.get_overlapping_bodies()
	
	if (not potential_targets.is_empty()):
		chasing_state.target = (potential_targets[0] as CharacterBody2D)
		change_state.emit(chasing_state)
		#if (not shoot_targets.is_empty()):
			#change_state.emit(shooting_state)
