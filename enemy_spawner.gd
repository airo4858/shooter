extends Node
# Preload the character scene
var enemy_scene = preload("res://Actors/enemy.tscn")
var enemy_scene2 = preload("res://Actors/enemy_2.tscn")

func _ready():
	# Start the timer when the scene is ready
	$SpawnTimer.start()

# Function to spawn characters
func _on_SpawnTimer_timeout():
	var spawn_place1 = Vector2(randf()*300, 600)
	var spawn_place2 = Vector2(randf()* 100,100)
	var spawn_place3 = Vector2(1100,randf() * 100 + 500)
	print("spawn")
	if randi() % 3 == 0:
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = spawn_place1
		add_child(enemy_instance)
	elif randi() % 3 == 1:
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = spawn_place2
		add_child(enemy_instance)
	else:
		var enemy_instance = enemy_scene2.instantiate()
		enemy_instance.position = spawn_place3
		add_child(enemy_instance)
