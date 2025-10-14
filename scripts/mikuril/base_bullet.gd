extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# print("real base bullet")
	velocity = Vector2(1, 0).rotated(rotation) * SPEED
	
	if velocity.y == 0 or velocity.x == 0: 
		queue_free()
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player_class:
		queue_free()
		print("hit")
	elif body.has_meta("floor") or body.has_meta("platform"):
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
