extends CharacterBody3D

@export var MovementJoystick: Control
@export var ChatBox: Panel

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_just_pressed("game_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if MovementJoystick:
		if MovementJoystick.isMoving:
			var direction = (transform.basis * Vector3(MovementJoystick.vector.x, 0, MovementJoystick.vector.z)).normalized() * 2.25
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		if ChatBox:
			if ChatBox.focused == true:
				return
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
