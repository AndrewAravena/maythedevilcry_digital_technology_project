extends CharacterBody2D

@export var homing_bullet_scene : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _attack_phase_one():
	var homing_bullet = homing_bullet_scene.instantiate()
	for i in 3:
		add_sibling(homing_bullet)
