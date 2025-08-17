extends CharacterBody2D

class_name fast_delay_bullet_class

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var can_move = false


func _physics_process(delta: float) -> void:
	if can_move == true:
		velocity = Vector2(1, 0).rotated(rotation) * SPEED
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player_class:
		queue_free()
		print("hit")
	elif body.has_meta("floor") or body.has_meta("platform"):
		queue_free()
		print("queue free")


func _on_timer_timeout() -> void:
	can_move = true


func _on_timer_2_timeout() -> void:
	queue_free()
