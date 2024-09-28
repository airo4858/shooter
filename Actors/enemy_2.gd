extends CharacterStateMachine
class_name Enemy2

@export var hp: int = 4
@export var small_enemy: Resource

func hit(damage_number: int):
	hp -= damage_number
	if (hp <= 0):
		queue_free()
		var new_enemy1 = small_enemy.instantiate()
		var new_enemy2 = small_enemy.instantiate()
		get_parent().add_child(new_enemy1)
		get_parent().add_child(new_enemy2)
		new_enemy1.position = position + Vector2(15,15)
		new_enemy2.position = position + Vector2(-15,-15)
		get_tree().get_root().get_node("Main/HUD").add_score(10)
