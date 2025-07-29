extends Node2D

@export var big_atk_pos : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	big_atk_pos = get_tree().get_first_node_in_group("bigAtkPos")
	global_position = big_atk_pos.global_position
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
