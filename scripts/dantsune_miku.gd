extends CharacterBody2D

@export var horns_hp_bar_path: NodePath
@onready var horns_hp_bar = get_node(horns_hp_bar_path)
@onready var _animated_sprite = $AnimationPlayer
@onready var sword_jump = $boxhit
@onready var sword_jump_timer: Timer = $boxhit/Sword_Jump_Timer
@export var weapon_select_path : NodePath
@onready var weapon_select_display = get_node(weapon_select_path)
@export_category("Movement variable")

var SPEED = 200
var GRAVITY = 500.0
@export_range(0.0, 1.0) var friction = 0.8
@export_range(0.0 , 1.0) var acceleration = 0.4
@export var SWORD_JUMP_STRENGTH = 50


@export var JUMP_VELOCITY = 15.0
var dash_ready : bool = false
var is_dashing = false
@export var JUMP_AMOUNT = 2
@export var accel = 290.0

var attacking = false
var attack_weapon = "String"
var current_equipped: String
var weapon_select = ["sword", "gun", "scythe"]
var current_equipped_int: int = 0
var min_wepons: int = 0
var max_wepons: int = 2
var PLAYER_WEIGHT := 0.4
var weapons_damage = {
	"scythe" : 350,
	"sword": 150, 
	"gun": 200
}
@export var orbs_amount := 1 

var horns: int = 6




func _ready() -> void:
	# sets the default on 
	_animated_sprite.play("idle")
	current_equipped = "sword"
	

func _physics_process(delta):
	# sets the physics
	if not is_on_floor() and not is_dashing:
		velocity.y += GRAVITY * delta
	jump_logic()
	_animation_play()
	
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * SPEED, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		
	if Input.is_action_pressed("left"):
		$Node2D.scale.x = -1
	if Input.is_action_pressed("right"):
		$Node2D.scale.x = 1
	if Input.is_action_just_pressed("next weapon"):
		weapon_equipped(1)
	elif  Input.is_action_just_pressed("last weapon"):
		weapon_equipped(-1)
	# makes sure the player is dashing while in air and not on the floor and if they can dash
	if Input.is_action_just_pressed("dash")and not is_on_floor() and dash_ready == true:
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
	
	

func _input(event: InputEvent) -> void: # handles double clicks 
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT :
		if event.is_pressed():
			if event.double_click:	
				_animated_sprite.play(current_equipped + "_second") # plays the double click animation
				attacking = true
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
		JUMP_AMOUNT = 2 # resets the amounts of jumps the player has 
		if Input.is_action_just_pressed("Jump"):
			JUMP_AMOUNT -= 1
			velocity.y = -lerp( GRAVITY, JUMP_VELOCITY, PLAYER_WEIGHT )
			dash_ready = true # sets the dashing variable to true 
	if not is_on_floor():
		if JUMP_AMOUNT > 0:
			if Input.is_action_just_pressed("Jump"):
				JUMP_AMOUNT -= 1
				_animated_sprite.play("double jump")
				velocity.y = -lerp( JUMP_VELOCITY, GRAVITY , PLAYER_WEIGHT )
				await _animated_sprite.animation_finished
				_animated_sprite.play("walking")
			if Input.is_action_just_released("Jump"):
				velocity.y *= 0.3

func sword_jump_logic():
	if Input.is_action_just_pressed("sword_jump") and sword_jump_timer.is_stopped():
		sword_jump_timer.start()
		_animated_sprite.play("sword jumpp")
		await _animated_sprite.animation_finished
		_animated_sprite.play("walking")
	if not sword_jump_timer.is_stopped():
		var bodies = sword_jump.get_overlapping_bodies()
		attacking = true
		if len(bodies) > 0: # checks if it hit a body 
			velocity.y = -lerp( JUMP_VELOCITY, GRAVITY, PLAYER_WEIGHT )
			velocity.y += SWORD_JUMP_STRENGTH
			if JUMP_AMOUNT < 1 : # allows for double jumps after sword jump
				JUMP_AMOUNT += 1

func weapon_animation():
	_animated_sprite.play(attack_weapon)

func weapon_equipped(next:int): # handles the "damage" due to knowing what weapon is selected 
	var swap_dir: int  # allows for weapon selection to know which direction 
	var previous_equipped = current_equipped # keeps previous equipped for weapon select 
	current_equipped_int += next # next is either positive or negative meaning forwards or backwards 
	if current_equipped_int > max_wepons:
		current_equipped_int = min_wepons
		
	if current_equipped_int < min_wepons:
		current_equipped_int = max_wepons
		
	current_equipped = weapon_select[current_equipped_int]
	attack_weapon = current_equipped
	weapon_select_display.get_weapon( current_equipped , previous_equipped , next)
	
func weapon_body_entered(body: Node2D) -> void:
	if attacking :
		if body is Enemy:
			 # runs the damage calculation function whenever an enemy is hit 
			body.take_damage(damage_calculations())

func update_hp_bar():
	horns_hp_bar.set_hp(horns)

func damage_calculations():
	# returns the total damage of the player then gets sent to the enemy 
	return ((weapons_damage[current_equipped])*orbs_amount) 

func damage_recieved(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is Enemy:
		horns -= parent.damage_to_deal
		horns = max(horns, 0)
		update_hp_bar()
	if horns <= 0:
		get_tree().reload_current_scene()
		queue_free()
			
	if parent is not Enemy and collision_layer == 3 :
		horns -= 1
		horns = max(horns, 0 )
		update_hp_bar()
