extends State

@export var chase_speed: float = 55.0
var target: CharacterBody2D
var animation : AnimationPlayer

func initialize():
	animation = body.get_node("AnimationEnemy2")

func process_state(delta: float):
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	
	var direction = (target.position - body.position).normalized()
	var angle = rad_to_deg(body.velocity.angle()) + 180
	if(angle > 135 and angle < 225):
		animation.play("enemy2_right")
	elif(angle > 225 and angle < 315):
		animation.play("enemy2_down")
	elif(angle > 315 or angle < 45):
		animation.play("enemy2_left")
	elif(angle > 45 and angle < 135):
		animation.play("enemy2_up")
