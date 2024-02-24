# This script just deals with player movement, camera movement is in the CamOrigin script.

extends CharacterBody3D

var speed = 10.0
var turn_speed = 30

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var parent

@onready var cam_h = $"../CamOrigin/h"
@onready var cam_v = $"../CamOrigin/h/v"

func _ready():
	# set mouse mode captured so it locks in middle of screen
	capture_mouse()
	
	# set parent
	parent = get_parent()

func _unhandled_input(event):
	# if "exit" (esc) is pressed, close game
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

func _process(delta):
	# set parent position to equal CharacterBody position every frame
	parent.position = position

func _physics_process(delta):
	# turn player inputs into a vector
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	
	# use input_dir movement vector to know which direction the player is facing, depending on the camera rotation 
	# put .normalized() at the end of this line if you don't want the player to be able to slow walk using joystick
	var direction = (cam_h.transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	
	# if playerBody isn't on the floor, activate gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if direction:
		# player movement
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
		# change player model rotation
		rotation.y = lerp_angle(rotation.y, atan2(-direction.x, -direction.z), turn_speed * delta)
	
	else:
		# if no direction input, make sure player is still
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()

func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func release_mouse():
	# not used anywhere in this demo, but you probably will want to run this func for menus and stuff
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
