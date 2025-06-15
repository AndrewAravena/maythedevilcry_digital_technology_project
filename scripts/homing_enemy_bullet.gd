extends Area2D

var player : Node

func _ready() -> void:
	for players in get_tree().get_nodes_in_group("player"):
		player = players

func _process(delta: float) -> void:
	if not player == null:
		look_at(player.global_position)
