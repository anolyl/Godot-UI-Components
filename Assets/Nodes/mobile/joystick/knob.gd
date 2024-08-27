extends TextureRect

@export var deadzone = 0
@export var maximumLength = 75.0

@onready var joystick = $".."
@onready var joystickPosition = joystick.global_position + (joystick.get_size() / 2)

var isPressing = false 

func calculateVector():
	var displacement = (global_position + (joystick.get_size() / 4)) - joystickPosition
	var length = displacement.length()

	if length >= deadzone:
		var clamped_length = min(length / maximumLength, 1.0)
		var normalized_displacement = displacement / maximumLength
		joystick.vector = Vector3(clamp(normalized_displacement.x, -1, 1), 0, clamp(normalized_displacement.y, -1, 1))
	else:
		joystick.vector = Vector3.ZERO

func _process(delta):
	if isPressing:
		var mouse_pos = get_global_mouse_position()
		var displacement = mouse_pos - joystickPosition

		if displacement.length() <= maximumLength:
			global_position = mouse_pos - (joystick.get_size() / 4)
		else:
			var angle = joystickPosition.angle_to_point(mouse_pos)
			global_position.x = joystickPosition.x - (joystick.get_size().x / 4) + cos(angle) * maximumLength
			global_position.y = joystickPosition.y - (joystick.get_size().y / 4) + sin(angle) * maximumLength

		calculateVector()
		joystick.isMoving = true
	else:
		global_position = lerp(global_position, joystick.global_position + (joystick.get_size() / 4), delta * 15)
		joystick.vector = Vector3.ZERO
		joystick.isMoving = false

func _on_knob_button_button_down():
	isPressing = true
	joystick.hideObstructiveButtons(true)

func _on_knob_button_button_up():
	isPressing = false
	joystick.hideObstructiveButtons(false)
