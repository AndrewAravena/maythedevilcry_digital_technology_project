extends Control
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
func _ready() -> void:
	animated_sprite_2d.play()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/level_one.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_opition_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/Options.tscn")
