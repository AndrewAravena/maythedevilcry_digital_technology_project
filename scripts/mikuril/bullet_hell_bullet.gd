extends RigidBody2D

@export var speed := Vector2(0,250)
@export var gravity := Vector2(0,0)
var time := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func ini(new_speed : Vector2, colour : String = "default", new_gravity := 0.0):
	gravity = Vector2(0,new_gravity)
	speed = new_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_d) -> void:
	time += _d
	linear_velocity = speed + (gravity * time)
	
