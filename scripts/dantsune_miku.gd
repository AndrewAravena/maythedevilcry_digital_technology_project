extends CharacterBody2D

@export var horns_hp_bar_path: NodePath
@onready var horns_hp_bar = get_node(horns_hp_bar_path)

@onready var _animated_sprite = $AnimationPlayer
@onready var sword_jump = $boxhit
@onready var sword_jump_timer: Timer = $boxhit/Sword_Jump_Timer

@export_category("Movement variable")
@export var speed = 200

@export var gravity = 500.0
@export_range(0.0, 1.0) var friction = 0.8
@export_range(0.0 , 1.0) var acceleration = 0.4
@export var sword_jump_strongy = 50

@export_category("Jump variable")
@export var JUMP_VELOCITY = -200.0
var dash_ready : bool = false
var is_dashing = false
@export var jump_speed = -150.0
@export var jump_ammount = 2
@export var accel = 290.0

var attacking = false
var attack_weapon = "String"
var current_equipped: String
var weapon_select = ["sword", "gun", "scythe"]
var current_equipped_int: int = 0
var min_wepons: int = 0
var max_wepons: int = 2



var horns: int = 5





func _physics_process(delta):
	
	
	
	if not is_on_floor() and not is_dashing:
		velocity.y += gravity * delta
	jump_logic()
	
	
	_animation_play()
	
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	if Input.is_action_pressed("left"):
		$Node2D.scale.x = -1
		
	if Input.is_action_pressed("right"):
		$Node2D.scale.x = 1

	if Input.is_action_just_pressed("dash")and dash_ready == true :
		dash_ready = false
		is_dashing = true
		if is_dashing == true:
			_animated_sprite.play("dash")
		$dashTimer.start()
		
	
	if is_dashing:
		velocity.y = 0
		velocity.x += 100 *dir
		if $dashTimer.is_stopped():
			is_dashing = false
	
	sword_jump_logic()
	move_and_slide()
	
	weapon_equipped()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT :
		if event.is_pressed():
			if event.double_click:
				_animated_sprite.play(current_equipped + "_second")
			else :
				attack()
	
	
	
	
func _animation_play():
	if attacking == true:
		await _animated_sprite.animation_finished
		_animated_sprite.play("walking")

func attack():
	
	attacking = true
	_animated_sprite.stop()
	_animated_sprite.play(current_equipped)
	await _animated_sprite.animation_finished
	_animated_sprite.stop()


func _on_touchy_touch_death(body):
	if body.has_meta("death"):
		get_tree().reload_current_scene()

func jump_logic():
	if is_on_floor():
		jump_ammount = 2
		
		if Input.is_action_just_pressed("Jump"):
			jump_ammount -= 1
			
			velocity.y = JUMP_VELOCITY
			dash_ready = true
			print(velocity.x)
	if not is_on_floor():
		if jump_ammount > 0:
			if Input.is_action_just_pressed("Jump"):
				jump_ammount -= 1
				_animated_sprite.play("double jump")
				velocity.y = JUMP_VELOCITY
				await _animated_sprite.animation_finished
				_animated_sprite.play("walking")
				
				
				
			
			if Input.is_action_just_released("Jump"):
				velocity.y = lerp(velocity.y, gravity, 0.02)
				velocity.y *= 0.3
	else:
		return

func sword_jump_logic():
	if Input.is_action_just_pressed("sword_jump") and sword_jump_timer.is_stopped():
		sword_jump_timer.start()
		_animated_sprite.play("sword jumpp")
		await _animated_sprite.animation_finished
		_animated_sprite.play("walking")
	if not sword_jump_timer.is_stopped():
		var bodies = sword_jump.get_overlapping_bodies()
		if len(bodies)>0:
			velocity.y-= sword_jump_strongy

func _on_swordhit_area_entered(area: Area2D) -> void:
	if area.is_in_group("hitbox"):
		area.take_damage

func weapon_animation():
	_animated_sprite.play(attack_weapon)

func weapon_equipped():
	var next: int = 1
	if Input.is_action_just_pressed("next weapon"):
		if current_equipped_int == max_wepons:
			current_equipped_int = min_wepons
		else:
			current_equipped_int +=1
	if Input.is_action_just_pressed("last weapon"):
		if current_equipped_int == min_wepons:
			current_equipped_int = max_wepons
		else:
			current_equipped_int -= 1
	current_equipped = weapon_select[current_equipped_int]
	


func weapon_body_entered(body: Node2D) -> void:
	if attacking :
		if body is Enemy:
			body.take_damage()
			
			
			
			


func take_damage(body: Node2D) -> void:
	if body is Enemy:
		horns -= body.damage_to_deal
		horns = max(horns, 0)
		update_hp_bar()
		if horns <= 0:
			get_tree().reload_current_scene()
			queue_free()
func update_hp_bar():
	horns_hp_bar.set_hp(horns)

			

			
