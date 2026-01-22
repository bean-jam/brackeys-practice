extends CharacterBody3D

const ROTATION_SPEED = 2.5
const SPEED = 20.0
const JUMP_VELOCITY = 4.5

@onready var camera: Camera3D = $Camera3D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Add Rotation to camera
	var rotation_input := Input.get_vector("rotate_left", "rotate_right", "rotate_up", "rotate_down")
	var rotation_direction := Vector3(rotation_input.x, rotation_input.y, 0).normalized()
	
	# Controls had to be inverted for it to not be inverted in game
	# I'm not sure why but it works
	if rotation_direction:
		rotation_degrees.x -= rotation_direction.y * ROTATION_SPEED 
		rotation_degrees.y -= rotation_direction.x * ROTATION_SPEED
		print(rotation_degrees)
	
	move_and_slide()
