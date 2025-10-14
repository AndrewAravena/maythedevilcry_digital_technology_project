extends Control
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play()
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") :
		visible = not visible
		get_tree().paused = not get_tree().paused
		
	
	


func _on_resume_pressed() -> void:
	visible = not visible
	get_tree().paused = false


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/Options.tscn")
