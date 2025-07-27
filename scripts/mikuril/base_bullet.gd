extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# print("real base bullet")
	velocity = Vector2(1, 0).rotated(rotation) * SPEED
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player_class:
		queue_free()
		print("hit")
	elif body.has_meta("floor"):
		queue_free()
