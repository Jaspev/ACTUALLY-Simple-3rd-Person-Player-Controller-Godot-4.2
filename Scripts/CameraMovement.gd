extends Node3D

var mouse_sensitivity = 0.005
var twist_input = 0.0
var pitch_input = 0.0

@onready var twist_pivot = $h
@onready var pitch_pivot = $h/v
@onready var player_bod = $"../PlayerBody"

func _process(delta):
	# rotate cam depending on cam pivots
	# cam pivot rotations are gotten from the _unhandled_input func below
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	
	# make sure player can't rotate the camera too far up or down
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		deg_to_rad(-90),
		deg_to_rad(45)
	)
	twist_input = 0.0
	pitch_input = 0.0

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
