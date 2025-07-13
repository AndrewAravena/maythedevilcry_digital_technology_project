extends Control

@onready var sprite := $AnimatedSprite2D

func play_hp_full():
	sprite.play("full")

func play_damaged():
	sprite.play("damaged")
