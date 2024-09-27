extends CharacterStateMachine
class_name Enemy2

@export var hp: int = 4

func hit(damage_number: int):
	hp -= damage_number
	if (hp <= 0):
		queue_free()
		get_tree().get_root().get_node("Main/HUD").add_score(20)
