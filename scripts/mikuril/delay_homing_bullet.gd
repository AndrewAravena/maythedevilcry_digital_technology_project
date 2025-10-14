extends Area2D

var player: Node
var first_pos: Node
var can_track = false
var direction = Vector2.ZERO
var go_to_ini_pos = true
const SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	first_pos = get_tree().get_first_node_in_group("delay")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player == null:
		if can_track == true:
			direction = (player.global_position - global_position).normalized()
			rotation = direction.angle()
			
			can_track = false 
			$Timer.start()
			go_to_ini_pos = false
		if can_track == false and go_to_ini_pos == true:
			direction = (first_pos.global_position - global_position).normalized()
			rotation = direction.angle()
		position += direction * SPEED * delta
	else:
		print("did not find player")



func _on_timer_timeout() -> void:
	can_track = true


func _on_delay_timer_timeout() -> void:
	can_track = true




func _on_body_entered(body: Node2D) -> void:
	if body is player_class:
		queue_free()
		print("hit")


func _on_alive_timeout() -> void:
	queue_free()
