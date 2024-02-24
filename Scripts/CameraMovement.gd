extends Node3D

var mouse_cam_sensitivity = 0.005
var joystick_cam_sensitivity = 0.1
var twist_input = 0.0
var pitch_input = 0.0
var input_dir

@onready var twist_pivot = $h
@onready var pitch_pivot = $h/v

func _physics_process(delta):
	# joystick compatability
	input_dir = Input.get_vector("look_left", "look_right", "look_up", "look_down")
	twist_pivot.rotate_y(-input_dir.x * joystick_cam_sensitivity)
	pitch_pivot.rotate_x(-input_dir.y * joystick_cam_sensitivity)
	
	# mouse compatability
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
	# inputs for mouse
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = -event.relative.x * mouse_cam_sensitivity
			pitch_input = -event.relative.y * mouse_cam_sensitivity
