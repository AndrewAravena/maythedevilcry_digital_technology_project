extends HBoxContainer

@export var max_hp := 5
var current_hp := 5
var old_hp := 5

const HEART_SCENE := preload("res://scene/horns_health.tscn")

func _ready() -> void:
	fill_hearts()

func fill_hearts():
	for child in get_children():
		child.queue_free()
	for i in range(max_hp):
		var heart = HEART_SCENE.instantiate()
		heart.name = "heart_%d" % i
		add_child(heart)
	update_hearts()

func update_hearts():
	for i in range(max_hp):
		var heart = get_child(i)
		if i >= current_hp and i < old_hp:
			heart.play_damaged()
		elif i < current_hp:
			heart.play_hp_full()
		else:
			pass
	old_hp = current_hp

func set_hp(value: int):
	current_hp = clamp(value, 0, max_hp)
	update_hearts()
