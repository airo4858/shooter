extends State

@export var chase_speed: float = 30.0
var target: CharacterBody2D
var shoot_range : Area2D
var shooting_state : State
var animation : AnimationPlayer

func initialize():
	shoot_range = body.get_node("ShootRange")
	shooting_state = get_parent().get_node("Shooting")
	animation = body.get_node("AnimationEnemy1")

func process_state(delta: float):
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	
	var direction = (target.position - body.position).normalized()
	var angle = rad_to_deg(body.velocity.angle()) + 180
	if(angle > 135 and angle < 225):
		animation.play("enemy1_right")
	elif(angle > 225 and angle < 315):
		animation.play("enemy1_down")
	elif(angle > 315 or angle < 45):
		animation.play("enemy1_left")
	elif(angle > 45 and angle < 135):
		animation.play("enemy1_up")
	
	var shoot_targets = shoot_range.get_overlapping_bodies()
	
	if (not shoot_targets.is_empty()):
		shooting_state.target = (shoot_targets[0] as CharacterBody2D)
		change_state.emit(shooting_state)
