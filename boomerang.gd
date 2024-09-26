extends Area2D

var velocity: Vector2 = Vector2(0,0)
var direction: float = 1.0
var slow: float = 0.98
var fast: float = 1.02
var reverse: bool = false

func fire(forward: Vector2, speed: float):
	velocity = forward * speed
	look_at(position + forward)
	update_rotation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not reverse:
		position += velocity * delta
		velocity *= slow
		if velocity.length() < 10:
			reverse = true
	
	if reverse:
		# Calculate direction to move back to the player
		
		# Update position based on new velocity
		position += -velocity * delta
		velocity *= fast
	update_rotation()

func update_rotation():
	# Calculate the angle from velocity
	direction += 0.5
	if (direction == 359):
		direction = -359
	rotation = direction

func _on_time_to_live_timeout():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	body.hit(1)
