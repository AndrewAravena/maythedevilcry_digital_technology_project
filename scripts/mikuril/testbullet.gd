extends CharacterBody2D


var player

func _ready():
	player = get_node("/root/Main/Player")

func _process(_delta):
	if player:
		look_at(player.global_position)

	move_and_slide()
