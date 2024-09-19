extends CharacterBody2D

@export var projectile_scene: Resource
@export var boomerang_scene: Resource
@export var spell_scene: Resource
@export var move_speed: float = 80.0

var can_shoot: bool = true
var can_spell: bool = true
var spell_hold_time: float = 0.0
var spell_holding: bool = false
var spell_speed: float = 300.0

func _input(event):
	if (event is InputEventMouseButton):
		if (event.button_index == 1 and event.is_pressed()):
			var new_projectile = projectile_scene.instantiate()
			get_parent().add_child(new_projectile)
			
			var projectile_forward = Vector2.from_angle(rotation)
			new_projectile.fire(projectile_forward, 300.0)
			new_projectile.position = $ProjectileRevPoint.global_position

func _input2(event):
	var new_boomerang = boomerang_scene.instantiate()
	get_parent().add_child(new_boomerang)
	
	var boomerang_forward = Vector2.from_angle(rotation)
	new_boomerang.fire(boomerang_forward, 300.0)
	new_boomerang.position = $ProjectileRevPoint.global_position
	
func _input3(event):
	var new_spell = spell_scene.instantiate()
	get_parent().add_child(new_spell)
	
	var spell_forward = Vector2.from_angle(rotation)
	new_spell.fire(spell_forward, spell_speed)
	new_spell.position = $SpellRevPoint.global_position

func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	move_and_slide()
	
	if (Input.is_action_pressed("spell")):
		if can_spell:
			can_spell = false
		spell_holding = true
		spell_hold_time = 0.0
		
	if (spell_holding):
		spell_hold_time += delta
	
	if (Input.is_action_just_released("spell")):
		if (spell_hold_time <= 1):
			_input3("spell")
		elif (spell_hold_time >1 and spell_hold_time <= 2):
			spell_speed += 100
			_input3("spell")
		elif (spell_hold_time > 2):
			spell_speed += 200
			_input3("spell")
		can_spell = true
		spell_holding = false
	
	if (Input.is_action_pressed("boomerang")):
		if can_shoot:
			_input2("boomerang")
			can_shoot = false
	if (Input.is_action_just_released("boomerang")):
		can_shoot = true
