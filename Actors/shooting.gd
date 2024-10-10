extends State

@onready var target: CharacterBody2D
var projectile: Area2D
var is_chasing : bool = true
var shoot_time: float = 1.0
var projectile_speed: float = 100.0
@export var enemy_projectile: Resource
var animation : AnimationPlayer
var hit_range : Area2D

func initialize():
	target = get_node("Main/Player")
	animation = body.get_node("AnimationEnemy1")
	hit_range = body.get_node("HitRange")

func process_state(delta: float):
	is_chasing = false
	aim_and_shoot(delta)
	var direction = (target.position - body.position).normalized()
	var angle = rad_to_deg(body.velocity.angle()) + 180
	if(angle > 135 and angle < 225):
		animation.play("shoot_right")
	elif(angle > 225 and angle < 315):
		animation.play("shoot_down")
	elif(angle > 315 or angle < 45):
		animation.play("shoot_left")
	elif(angle > 45 and angle < 135):
		animation.play("shoot_up")
		
	var hit_targets = hit_range.get_overlapping_bodies()
	if (not hit_targets.is_empty()):
		get_tree().get_root().get_node("Main/Player").hurt(1)
		body.queue_free()
	
func aim_and_shoot(delta):
	look_at(target.position)
	shoot_time -= delta
	if (shoot_time < 0):
		shoot()
		shoot_time = 1.0
		projectile_speed += 1

func shoot():
	var new_projectile = enemy_projectile.instantiate()
	var direction = (target.position - body.position).normalized()
	get_parent().add_child(new_projectile)  # Add projectile to the scene
	var projectile_forward = body.position.direction_to(target.position)
	#var projectile_forward = Vector2.from_angle(rotation)
	new_projectile.fire(projectile_forward, projectile_speed)
	new_projectile.position = body.position  # Set the starting position
