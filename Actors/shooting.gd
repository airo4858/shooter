extends State

@onready var target: CharacterBody2D
@onready var enemy: CharacterBody2D
var projectile: CharacterBody2D
var is_chasing : bool = true
var shoot_time: float = 1.5
@export var enemy_projectile: Resource


func ready():
	target = get_node("Main/Player")
	enemy = get_node("Main/Enemy")
	projectile = enemy_projectile.instantiate()

func process_state(delta: float):
	#print("I shitted my pants")
	is_chasing = false
	#aim_and_shoot()
	
func aim_and_shoot():
	look_at(target.position)
	shoot()

func shoot():
	get_parent().add_child(projectile)  # Add projectile to the scene
	enemy_projectile.position = enemy.position  # Set the starting position
	enemy_projectile.direction = (target.position - enemy.position).normalized()
