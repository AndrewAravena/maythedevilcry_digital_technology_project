extends CharacterBody2D



@export var homing_bullet_scene : PackedScene
@export var homing_bullet_spawn : Node
@export var player : Node
@export var homing_bullet_rotation : Node
var can_shoot_homing_bullet = true
var homing_bullets_shot = 1
var can_shoot_homing_bullets_again = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for players in get_tree().get_nodes_in_group("player"):
		player = players


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if homing_bullets_shot <= 3 and can_shoot_homing_bullets_again == true:
		_attack_phase_one()
	if homing_bullets_shot >= 3 and can_shoot_homing_bullets_again == false:
		# change timer here to increase time between each burst of shots
		$Timer.start(3)
		homing_bullets_shot = 1



func _attack_phase_one():
	var homing_bullet = homing_bullet_scene.instantiate()
	homing_bullet.global_position = homing_bullet_spawn.global_position
	if can_shoot_homing_bullet == true:
		add_sibling(homing_bullet)
		# homing_bullet.rotation = player.global_position
		can_shoot_homing_bullet = false
		$Timer.start()
		homing_bullets_shot += 1

func _on_timer_timeout() -> void:
	can_shoot_homing_bullet = true


func _on_timer_2_timeout() -> void:
	can_shoot_homing_bullets_again = true
	homing_bullets_shot = 1
