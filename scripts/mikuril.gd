extends CharacterBody2D



@export var homing_bullet_scene : PackedScene
@export var homing_bullet_spawn : Node
@export var homing_bullet_rotation : Node
@export var base_slash_scene : PackedScene
@export var delay_homing_bullet_scene : PackedScene
@export var fast_bullet_scene: PackedScene
var player : Node
var can_shoot_homing_bullet = true
var can_shoot_delay_bullet = false
var homing_bullets_shot = 1
var delay_bullets_shot = 1
var can_shoot_homing_bullets_again = true
var can_shoot_delay_again = true
var ready_to_tp = false
var can_attack_3 = false
@onready var old_pos = self.global_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	$delayHomingTimer.start()
	# var player_pos = player.global_position
	# _tp(player_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player = get_tree().get_first_node_in_group("player")
	var player_pos = player.global_position
	if homing_bullets_shot <= 3 and can_shoot_homing_bullets_again == true:
		_attack_one()
		$readyToTpTimer.start()
	_attack_two()
	if delay_bullets_shot <= 3 and can_shoot_delay_again == true:
		_attack_three()
	_attack_four()
			# elif homing_bullets_shot == 3 and can_shoot_homing_bullets_again == false:
		# change timer here to increase time between each burst of shots
		# $Timer2.start()
		# homing_bullets_shot = 5



func _attack_one(): # homing bullet triple shot
	var homing_bullet = homing_bullet_scene.instantiate()
	homing_bullet.global_position = homing_bullet_spawn.global_position
	if can_shoot_homing_bullet == true:
		add_sibling(homing_bullet)
		# homing_bullet.rotation = player.global_position
		can_shoot_homing_bullet = false
		$Timer.start()
		homing_bullets_shot += 1

func _attack_two(): # tp slash atk
	var player_pos = player.global_position
	if ready_to_tp == true:
		_tp(player_pos)
		var base_slash = base_slash_scene.instantiate()
		base_slash.global_position = $Marker2D2.global_position
		add_sibling(base_slash)

func _tp(player_pos):
	self.global_position = player_pos + Vector2(50, 0)
	$tpBackTimer.start()
	ready_to_tp = false
	

func _attack_three():
	var delay_homing_bullet = delay_homing_bullet_scene.instantiate()
	delay_homing_bullet.global_position = homing_bullet_spawn.global_position
	if can_shoot_delay_bullet == true:
		add_sibling(delay_homing_bullet)
		can_shoot_homing_bullet = false
		$delayHomingTimer.start(1.0)
		delay_bullets_shot += 1
		print("worked")

func _attack_four():
	if can_attack_3 == true:
		var fast_bullet = fast_bullet_scene.instantiate()
		fast_bullet.rotation = (player.global_position - fast_bullet.global_position).normalized()
		for i in 20:
			add_sibling(fast_bullet)

func _on_timer_timeout() -> void:
	can_shoot_homing_bullet = true


func _on_timer_2_timeout() -> void:
	can_shoot_homing_bullets_again = true
	homing_bullets_shot = 1


func _on_tp_back_timer_timeout() -> void:
	self.global_position = old_pos
	$readyToTpTimer.start()

func _on_ready_to_tp_timer_timeout() -> void:
	ready_to_tp = true


func _on_delay_homing_timer_timeout() -> void:
	can_shoot_delay_bullet = true


func _on_timer_3_timeout() -> void:
	can_shoot_delay_again = true


func _on_atk_3_timeout() -> void:
	can_attack_3 = true
