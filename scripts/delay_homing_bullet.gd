extends Area2D

var player: Node
var can_track = false
var direction = Vector2.ZERO
const speed = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player == null:
		if can_track == true:
			direction = (player.global_position - global_position).normalized()
			rotation = direction.angle()
			
			can_track = false 
			$Timer.start()
		position += direction * speed * delta
	else:
		print("did not find player")



func _on_timer_timeout() -> void:
	can_track = true


func _on_delay_timer_timeout() -> void:
	can_track = true
