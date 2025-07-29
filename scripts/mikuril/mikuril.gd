extends CharacterBody2D



@export var homing_bullet_scene : PackedScene
@export var homing_bullet_spawn : Node
@export var homing_bullet_rotation : Node
@export var big_atk_pos : Node
@export var base_slash_scene : PackedScene
@export var delay_homing_bullet_scene : PackedScene
@export var fast_bullet_scene: PackedScene
@export var delay_fast_bullet: PackedScene
var player : Node
var can_shoot_homing_bullet = true
var can_shoot_delay_bullet = false
var homing_bullets_shot = 1
var delay_bullets_shot = 1
var can_shoot_homing_bullets_again = true
var can_shoot_delay_again = true
var ready_to_tp = false
var can_attack_4 = false
var big_atk_active = false
var big_atk_1 = true
@onready var old_pos = self.global_position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	$delayHomingTimer.start()
	$bulletHellMode/pos.look_at($bulletHellMode/direc.global_position)
	$bulletHellMode/pos1.look_at($bulletHellMode/pos1/direc1.global_position)
	$bulletHellMode/pos2.look_at($bulletHellMode/pos2/direc2.global_position)
	$bulletHellMode/pos3.look_at($bulletHellMode/pos3/direc3.global_position)
	$bulletHellMode/pos4.look_at($bulletHellMode/pos4/direc4.global_position)
	$bulletHellMode/pos5.look_at($bulletHellMode/pos5/direc5.global_position)
	$bulletHellMode/pos6.look_at($bulletHellMode/pos6/direc6.global_position)
	$bulletHellMode/pos7.look_at($bulletHellMode/pos7/direc7.global_position)
	$bulletHellMode/pos8.look_at($bulletHellMode/pos8/direc8.global_position)
	
	print($bulletHellMode.global_position)
	print($bulletHellMode/pos1.global_position)
	print($bulletHellMode/pos2.global_position)
	print($bulletHellMode/pos3.global_position)
	print($bulletHellMode/pos4.global_position)
	print($bulletHellMode/pos5.global_position)
	print($bulletHellMode/pos6.global_position)
	print($bulletHellMode/pos7.global_position)
	print($bulletHellMode/pos8.global_position)
	
	
	# var player_pos = player.global_position
	# _tp(player_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if big_atk_active == false:
		player = get_tree().get_first_node_in_group("player")
		var player_pos = player.global_position
		$towardPlayer.look_at(player_pos)
		if homing_bullets_shot <= 3 and can_shoot_homing_bullets_again == true:
			_attack_one()
			$readyToTpTimer.start()
		if delay_bullets_shot <= 3 and can_shoot_delay_again == true:
			_attack_three()
		_attack_two()

		if can_attack_4 == true:
			_attack_four()
				# elif homing_bullets_shot == 3 and can_shoot_homing_bullets_again == false:
			# change timer here to increase time between each burst of shots
			# $Timer2.start()
			# homing_bullets_shot = 5
	else:
		_big_attack()



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
		$atk4.start(3)

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
		# print("worked")

func _attack_four():
	var fast_bullet = fast_bullet_scene.instantiate()
	fast_bullet.rotation = $towardPlayer.rotation
	fast_bullet.global_position = $Marker2D2.global_position
	add_sibling(fast_bullet)
	# print("added bullet")
	can_attack_4 = false

func _big_attack():
	if big_atk_1 == true:
		self.global_position = big_atk_pos.global_position
		
		
		var bullet_hell_bullet0 = delay_fast_bullet.instantiate()
		bullet_hell_bullet0.global_position = $bulletHellMode/pos.global_position
		bullet_hell_bullet0.rotation = $bulletHellMode/pos.rotation
		add_sibling(bullet_hell_bullet0)
		
		var bullet_hell_bullet1 = delay_fast_bullet.instantiate()
		bullet_hell_bullet1.global_position = $bulletHellMode/pos1.global_position
		bullet_hell_bullet1.rotation = $bulletHellMode/pos1.rotation
		add_sibling(bullet_hell_bullet1)
		
		var bullet_hell_bullet2 = delay_fast_bullet.instantiate()
		bullet_hell_bullet2.global_position = $bulletHellMode/pos2.global_position
		bullet_hell_bullet2.rotation = $bulletHellMode/pos2.rotation
		add_sibling(bullet_hell_bullet2)
		
		var bullet_hell_bullet3 = delay_fast_bullet.instantiate()
		bullet_hell_bullet3.global_position = $bulletHellMode/pos3.global_position
		bullet_hell_bullet3.rotation = $bulletHellMode/pos3.rotation
		add_sibling(bullet_hell_bullet3)
		
		var bullet_hell_bullet4 = delay_fast_bullet.instantiate()
		bullet_hell_bullet4.global_position = $bulletHellMode/pos4.global_position
		bullet_hell_bullet4.rotation = $bulletHellMode/pos4.rotation
		add_sibling(bullet_hell_bullet4)
		
		var bullet_hell_bullet5 = delay_fast_bullet.instantiate()
		bullet_hell_bullet5.global_position = $bulletHellMode/pos5.global_position
		bullet_hell_bullet5.rotation = $bulletHellMode/pos5.rotation
		add_sibling(bullet_hell_bullet5)
		
		var bullet_hell_bullet6 = delay_fast_bullet.instantiate()
		bullet_hell_bullet6.global_position = $bulletHellMode/pos6.global_position
		bullet_hell_bullet6.rotation = $bulletHellMode/pos6.rotation
		add_sibling(bullet_hell_bullet6)
		
		var bullet_hell_bullet7 = delay_fast_bullet.instantiate()
		bullet_hell_bullet7.global_position = $bulletHellMode/pos7.position
		bullet_hell_bullet7.rotation = $bulletHellMode/pos7.rotation
		add_sibling(bullet_hell_bullet7)
		
		var bullet_hell_bullet8 = delay_fast_bullet.instantiate()
		bullet_hell_bullet8.global_position = $bulletHellMode/pos8.global_position
		bullet_hell_bullet8.rotation = $bulletHellMode/pos8.rotation
		add_sibling(bullet_hell_bullet8)
		
		print($bulletHellMode.global_position)
		print($bulletHellMode/pos1.global_position)
		print($bulletHellMode/pos2.global_position)
		print($bulletHellMode/pos3.global_position)
		print($bulletHellMode/pos4.global_position)
		print($bulletHellMode/pos5.global_position)
		print($bulletHellMode/pos6.global_position)
		print($bulletHellMode/pos7.global_position)
		print($bulletHellMode/pos8.global_position)
		big_atk_1 = false

func _on_timer_timeout() -> void:
	can_shoot_homing_bullet = true


func _on_timer_2_timeout() -> void:
	can_shoot_homing_bullets_again = true
	homing_bullets_shot = 1


func _on_tp_back_timer_timeout() -> void:
	self.global_position = old_pos
	# $readyToTpTimer.start()

func _on_ready_to_tp_timer_timeout() -> void:
	ready_to_tp = true


func _on_delay_homing_timer_timeout() -> void:
	can_shoot_delay_bullet = true


func _on_timer_3_timeout() -> void:
	can_shoot_delay_again = true


func _on_atk_4_timeout() -> void:
	can_attack_4 = true


func _on_big_atk_timer_timeout() -> void:
	big_atk_active = true


func _on_big_atk_over_timer_timeout() -> void:
	big_atk_active = false
	self.global_position = old_pos
