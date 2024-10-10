extends State

@export var chase_speed: float = 60.0
var target: CharacterBody2D
var hit_range : Area2D

func initialize():
	hit_range = body.get_node("HitRange")

func process_state(delta: float):
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	
	var hit_targets = hit_range.get_overlapping_bodies()
	if (not hit_targets.is_empty()):
		get_tree().get_root().get_node("Main/Player").hurt(1)
		body.queue_free()
