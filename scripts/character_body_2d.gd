extends CharacterBody2D
class_name Enemy

var player : CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var target = null
const speed = 100
const jump_speed = 0.5
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

var knockback_force = 100
var knockback := false 

func _ready() -> void:
	animated_sprite_2d.play("walk")
	player = get_tree().current_scene.get_player()

func _process(delta: float) -> void:	
	if !is_on_floor():
		velocity.y += gravity * delta
	var heheha =-(position.x - player.position.x)
	dir = player.position
	if position.distance_to(player.position) <250:
		if velocity.x == 0 and is_on_floor():
			velocity.y -= jump_speed*gravity
		if heheha <0:
			velocity.x = sign(heheha) * speed
		else:
			velocity.x = sign(heheha) * speed
	
		if knockback == true:
			velocity.x += -(heheha) * knockback_force
			knockback = false
	move_and_slide()
	
	


	

func choose(array):
	array.shuffle()
	return array.front()

func take_damage(damage_recieved):
	knockback = true
	health -= damage_recieved * (enemy_tier * enemy_level_dif)
	animated_sprite_2d.play("Take_Damage")
	if health <= 0:
		queue_free()
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play("walk")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("weapon"):
		
		take_damage(area.get_parent().get_parent().damage_calculations())
		
	
func _detected(body: Node2D) -> void:
	if body.is_in_group("player") :
		target = body
