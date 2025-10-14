extends Node2D

@export var platform : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	_summon_p()

func _summon_p():
	var platform_spawn = platform.instantiate()
	platform_spawn.global_position = Vector2(randi_range(0, 1152), randi_range(250, 350))
	add_child(platform_spawn)
