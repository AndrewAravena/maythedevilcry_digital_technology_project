extends CharacterBody2D



@export var homing_bullet_scene : PackedScene
@export var homing_bullet_spawn : Node
@export var homing_bullet_rotation : Node
var player : Node
var can_shoot_homing_bullet = true
var homing_bullets_shot = 1
var can_shoot_homing_bullets_again = true
var ready_to_tp = false
@onready var old_pos = self.global_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	# var player_pos = player.global_position
	# _tp(player_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_pos = player.global_position
	if homing_bullets_shot <= 3 and can_shoot_homing_bullets_again == true:
		_attack_one()
		$readyToTpTimer.start()

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

func _attack_twp(): # tp slash atk
	var player_pos = player.global_position
	if ready_to_tp == true:
		_tp(player_pos)
		

func _tp(player_pos):
	self.global_position = player_pos + Vector2(50, 0)
	$tpBackTimer.start()
	ready_to_tp = false
	

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
