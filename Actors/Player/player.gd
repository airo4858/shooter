extends CharacterBody2D

@export var projectile_scene: Resource
@export var boomerang_scene: Resource
@export var spell_scene: Resource
@export var move_speed: float = 100.0
@export var hp: int = 5

@onready var audio_game = $AudioStreamPlayer
@onready var audio_shoot = $AudioForClick
@onready var audio_boomerang = $AudioForBoomerang
@onready var audio_spell = $AudioForSpell
@onready var audio_hurt = $AudioForHurt

var can_shoot: bool = true
var can_spell: bool = true
var spell_hold_time: float = 0.0
var spell_holding: bool = false
var spell_speed: float = 300.0
var is_running: bool = false
var hit_player: Area2D

func _input(event):
	if (event is InputEventMouseButton):
		if (event.button_index == 1 and event.is_pressed()):
			var new_projectile = projectile_scene.instantiate()
			get_parent().add_child(new_projectile)
			audio_shoot.play()
			var projectile_forward = position.direction_to(get_global_mouse_position())
			#var projectile_forward = Vector2.from_angle(rotation)
			new_projectile.fire(projectile_forward, 300.0)
			new_projectile.position = $ProjectileRevPoint.global_position

func _input2(event):
	var new_boomerang = boomerang_scene.instantiate()
	get_parent().add_child(new_boomerang)
	audio_boomerang.play()
	var boomerang_forward = position.direction_to(get_global_mouse_position())
	#var boomerang_forward = Vector2.from_angle(rotation)
	new_boomerang.fire(boomerang_forward, 300.0)
	new_boomerang.position = $ProjectileRevPoint.global_position
	
func _input3(event):
	var new_spell = spell_scene.instantiate()
	get_parent().add_child(new_spell)
	audio_spell.play()
	var spell_forward = position.direction_to(get_global_mouse_position())
	#var spell_forward = Vector2.from_angle(rotation)
	new_spell.fire(spell_forward, spell_speed)
	new_spell.position = $SpellRevPoint.global_position

func hurt(damage_number: int):
	hp -= damage_number
	audio_hurt.play()
	get_tree().get_root().get_node("Main/HUD").take_damage(1)
	if (hp <= 0):
		audio_hurt.play()
		await audio_hurt.finished
		print("im dead af")
		get_tree().get_root().get_node("Main/HUD/End").visible = true
		get_tree().paused = true
		is_running = false
		visible = false

func _ready():
	audio_game.play()

func _physics_process(delta):
	#look_at(get_global_mouse_position())
	#visible = false
	#get_tree().paused = true
	get_tree().get_root().get_node("Main/HUD/End").visible = false
	if (not is_running):
		if (Input.is_action_just_pressed("StartScreen")):
			is_running = true
			#get_tree().paused = false
			get_tree().get_root().get_node("Main/HUD/Start").visible = false
			visible = true
		return

	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	move_and_slide()
		
		#MATH
	var angle = rad_to_deg(velocity.angle()) + 180
	if (velocity.length() < 10):
		$AnimationPlayer.play("the_idle")
	else:
		if(angle > 135 and angle < 225):
			$AnimationPlayer.play("new_walk_right")
		elif(angle > 225 and angle < 315):
			$AnimationPlayer.play("new_walk_front")
		elif(angle > 315 or angle < 45):
			$AnimationPlayer.play("new_walk_left")
		elif(angle > 45 and angle < 135):
			$AnimationPlayer.play("new_walk_up")
		
	if (Input.is_action_pressed("spell")):
		if can_spell:
			can_spell = false
		spell_holding = true
		if (spell_hold_time >1 and spell_hold_time <= 2):
			$Energy2.visible = true
		elif (spell_hold_time > 2):
			$Energy1.visible = true
			
	if (spell_holding):
		spell_hold_time += delta
		
	if (Input.is_action_just_released("spell")):
		if (spell_hold_time <= 1):
			_input3("spell")
		elif (spell_hold_time >1 and spell_hold_time <= 2):
			spell_speed += 150
			_input3("spell")
		elif (spell_hold_time > 2):
			spell_speed += 300
			_input3("spell")
		can_spell = true
		spell_holding = false
		spell_hold_time = 0.0
		spell_speed = 300
		$Energy1.visible = false
		$Energy2.visible = false
		
	if (Input.is_action_pressed("boomerang")):
		if can_shoot:
			_input2("boomerang")
			can_shoot = false
	if (Input.is_action_just_released("boomerang")):
		can_shoot = true
	
	
	#hit_player = get_node("HitPlayer")
	
#func _on_hit_player_body_entered(hit_player):
	#print("im dead af")
	#is_running = false
