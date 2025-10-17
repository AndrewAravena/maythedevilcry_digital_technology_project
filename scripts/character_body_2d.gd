extends CharacterBody2D
class_name Enemy

var player : CharacterBody2D

@onready var knockback_cooldown: Timer = $Knockback_cooldown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var target = null
const speed = 70
const jump_speed = 0.6
var is_enemy_chase: bool
var enemy_tier := 1
var enemy_level_dif := 1
var health = 5000
var dead: bool = false
var talking_damage: bool = false
var damage_to_deal = 1
var is_dealing_damage: bool = false
var dir: Vector2 
const gravity = 500

var knockback_force = 50
var knockback := false 
var DETECTION_RANGE := 250
var ATTACK_RANGE := 50

func _ready() -> void:
	animated_sprite_2d.play("walk")
	player = get_tree().current_scene.get_player()

func _process(delta: float) -> void:	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var heheha =-(position.x - player.position.x)
	dir = player.position
	
	if position.distance_to(player.position)< ATTACK_RANGE :
		if  animated_sprite_2d.is_playing():
			animated_sprite_2d.play("attack")
			
	elif position.distance_to(player.position)>100:
		animated_sprite_2d.play("walk")
		
	if position.distance_to(player.position) <DETECTION_RANGE: #cheks where the player is 
		#jumps if the enemy hits a wall 
		if velocity.x == 0 and is_on_floor():
			velocity.y -= jump_speed*gravity
			
		if heheha <0:
			velocity.x = sign(heheha) * speed
		else:
			velocity.x = sign(heheha) * speed
		# handles knockback 
		if knockback == true:
			velocity.x += -(heheha) * knockback_force
			knockback = false
	move_and_slide()

func take_damage(damage_recieved):
	if knockback == false and knockback_cooldown.is_stopped():
		knockback = true
		knockback_cooldown.start()
	#finishes the calculations increasing or decreasing total amount of damage 
	health -= damage_recieved * (enemy_tier * enemy_level_dif)
	animated_sprite_2d.play("Take_Damage")
	if health <= 0:
		queue_free()
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play("walk")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("weapon"):	
		take_damage(area.get_parent().get_parent().damage_calculations())
