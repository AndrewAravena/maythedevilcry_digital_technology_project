extends Area2D

@export var big_explosion_scene : PackedScene
const SPEED = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += SPEED * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_meta("floor"):
		print("worked")
		var explosion = big_explosion_scene.instantiate()
		explosion.global_position = self.global_position
		add_sibling(explosion)
		queue_free()
