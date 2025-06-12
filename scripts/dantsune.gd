extends CharacterBody2D


@onready var _animated_sprite = $AnimatedSprite2D

@export_category("Movement variable")
@export var speed = 200

@export var gravity = 500.0
@export_range(0.0, 1.0) var friction = 0.8
@export_range(0.0 , 1.0) var acceleration = 0.4
 

@export_category("Jump variable")
@export var JUMP_VELOCITY = -400.0
var dash_ready : bool = false
var is_dashing = false
@export var jump_speed = -150.0
@export var jump_ammount = 2
@export var accel = 290.0


func _physics_process(delta):
	if not is_on_floor() and not is_dashing:
		velocity.y += gravity * delta
	jump_logic()
	
		
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		
		
	
	
	if Input.is_action_just_pressed("dash")and dash_ready == true :
		dash_ready = false
		is_dashing = true
		$dashTimer.start()
		
	
	if is_dashing:
		velocity.y = 0
		velocity.x += 100 *dir
		if $dashTimer.is_stopped():
			is_dashing = false
		
		
	move_and_slide()
		
		



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
				
				velocity.y = JUMP_VELOCITY
				
			
			if Input.is_action_just_released("Jump"):
				velocity.y = lerp(velocity.y, gravity, 0.02)
				velocity.y *= 0.3
	else: 
		return
		
