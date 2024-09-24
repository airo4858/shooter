extends Node
# Preload the character scene
var enemy_scene = preload("res://Actors/enemy.tscn")
var spawn_place1 = Vector2(randf()*300, 600)
var spawn_place2 = Vector2(50,100)
var spawn_place3 = Vector2(1100,600)

func _ready():
	# Start the timer when the scene is ready
	$SpawnTimer.start()

# Function to spawn characters
func _on_SpawnTimer_timeout():
	print("spawn")
	# Instance the character and add it to the scene
	var enemy_instance = enemy_scene.instantiate()
	if randi() % 3 == 0:
		enemy_instance.position = spawn_place1
	elif randi() % 3 == 1:
		enemy_instance.position = spawn_place2
	else:
		enemy_instance.position = spawn_place3
	add_child(enemy_instance)
	
	# Optionally, set the position of the character
	#var spawn_position = Vector2(randf() * 300,600)
