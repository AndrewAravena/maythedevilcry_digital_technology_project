extends CharacterBody2D
class_name Enemy

var target = null
const speed = 4000
var is_enemy_chase: bool
var enemy_tier := 1
var enemy_level_dif := 0.5
var health = 500
var health_max = 20
var health_min = 0 

var dead: bool = false
var talking_damage: bool = false
var damage_to_deal = 1
var is_dealing_damage: bool = false

var dir: Vector2 
const gravity = 500 
var knockback_force = 200
var is_roaming: bool = true 
var damage_recieved:= 0 

func _process(delta: float) -> void:
	
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	
	
	
	move(delta)
	if target:
		look_at(target.position)
		position = lerp(position, target.position , delta * 1 ) 
	
	move_and_slide()
func move(delta):
	if !dead: 
		if!is_enemy_chase:
			velocity =+ dir* speed * delta 
		is_roaming = true
	elif dead: 
		velocity.x = 0 

func _on_direction_timer_timeout() -> void:
	$"direction timer".wait_time = choose([1.5,2.0,2.5])
	if !is_enemy_chase:
		dir = choose ([Vector2.RIGHT,Vector2.LEFT])
		velocity.x = 0
func choose(array):
	array.shuffle()
	return array.front()

func take_damage(damage_recieved):
	health -= damage_recieved * (enemy_tier * enemy_level_dif)
	print(damage_recieved)
	if health <= 0:
		queue_free()
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("weapon"):
		take_damage(area.get_parent().get_parent().damage_calculations())
	


func _detected(body: Node2D) -> void:
	if body.is_in_group("player") :
		target = body
