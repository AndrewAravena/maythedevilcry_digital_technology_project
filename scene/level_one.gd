extends Node2D

var player: CharacterBody2D

func get_player() -> CharacterBody2D:
	var children = get_children()
	for child in children:
		if child.is_in_group("player"):
			player = child
			break
	return player
