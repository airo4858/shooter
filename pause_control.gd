extends Control

func _ready():
	set_process_input(true)


func _input(event):
	if (Input.is_action_just_pressed("StartScreen")):
		get_tree().paused = false
		get_tree().get_root().get_node("Main/HUD/Start").visible = false
		visible = true
