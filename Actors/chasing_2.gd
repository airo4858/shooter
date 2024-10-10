extends State

@export var chase_speed: float = 55.0
var target: CharacterBody2D
var hit_range : Area2D
var animation : AnimationPlayer

func initialize():
	animation = body.get_node("AnimationEnemy2")
	hit_range = body.get_node("HitRange")


func process_state(delta: float):
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	var hit_targets = hit_range.get_overlapping_bodies()
	
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
		
	if (not hit_targets.is_empty()):
		get_tree().get_root().get_node("Main/Player").hurt(1)
		body.queue_free()
