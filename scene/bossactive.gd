extends Area2D

@onready var boss_char = get_tree().get_first_node_in_group("boss")
@export var boss_scene : PackedScene
@onready var player = get_tree().get_first_node_in_group("player")
var f = false



func _on_body_entered(body: Node2D) -> void:
	if body == player:
		var boss_spawn = boss_scene.instantiate()
		boss_spawn.global_position = $Node2D.global_position
		add_sibling(boss_spawn)
		print("boss spawned")
