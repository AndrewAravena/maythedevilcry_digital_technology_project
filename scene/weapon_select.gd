extends Control
@onready var weapon_select: AnimatedSprite2D = $WeaponSelect



func _ready() -> void:
	weapon_select.play("sword")
		
	
func get_weapon(current_equipped, previous_equipped, swap_dir):
	var dir : String
	if swap_dir <0:
		dir = "_decrease"
	else:
		dir = "_increase"
	weapon_select.play( previous_equipped + dir)
	await weapon_select.animation_finished
	weapon_select.play(current_equipped)
	
	
	
	
