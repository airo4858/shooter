extends State

@onready var target: CharacterBody2D
var projectile: Area2D
var is_chasing : bool = true
var shoot_time: float = 1.0
var projectile_speed: float = 100.0
@export var enemy_projectile: Resource


func initialize():
	target = get_node("Main/Player")

func process_state(delta: float):
	#print("I shitted my pants")
	is_chasing = false
	aim_and_shoot(delta)
	
func aim_and_shoot(delta):
	look_at(target.position)
	shoot_time -= delta
	if (shoot_time < 0):
		shoot()
		shoot_time = 1.0


func shoot():
	var new_projectile = enemy_projectile.instantiate()
	var direction = (target.position - body.position).normalized()
	get_parent().add_child(new_projectile)  # Add projectile to the scene
	var projectile_forward = body.position.direction_to(target.position)
	#var projectile_forward = Vector2.from_angle(rotation)
	new_projectile.fire(projectile_forward, projectile_speed)
	new_projectile.position = body.position  # Set the starting position
