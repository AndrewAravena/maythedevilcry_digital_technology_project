extends Area2D

const speed = 200
var direction = Vector2.ZERO
var can_track = true
var player: Node

func _ready() -> void:
	$queueFreeTimer.start()
	player = get_tree().get_first_node_in_group("player")

	pass
func _process(delta: float):
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


func _on_body_entered(body: Node2D) -> void:
	if body is player_class:
		queue_free()
		print("hit")
	# elif body.has_meta("floor"):
		# queue_free()


func _on_queue_free_timer_timeout() -> void:
	queue_free()
