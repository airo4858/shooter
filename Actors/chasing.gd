extends State

@export var chase_speed: float = 50.0
var target: CharacterBody2D
var shoot_range : Area2D
var shooting_state : State

func initialize():
	shoot_range = body.get_node("ShootRange")
	shooting_state = get_parent().get_node("Shooting")

func process_state(delta: float):
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	var shoot_targets = shoot_range.get_overlapping_bodies()
	
	if (not shoot_targets.is_empty()):
		shooting_state.target = (shoot_targets[0] as CharacterBody2D)
		change_state.emit(shooting_state)
