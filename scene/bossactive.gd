extends Area2D

@onready var boss_char = get_tree().get_first_node_in_group("boss")
var f = false


func _ready() -> void:
	boss_char.set_process(false)


func _on_body_entered(body: Node2D) -> void:
	if body == player_class:
		boss_char.set_process(true)
		queue_free()
