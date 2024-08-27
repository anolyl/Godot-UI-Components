extends Camera3D

enum MODE {
	PC,
	MOBILE
}

@export var Player: CharacterBody3D
@export var SpotLight: SpotLight3D
@export var MovementJoystick: Control
@export var ui: Control

@export var sensitivity = 0.1
@export var max_look_up_angle = 80
@export var max_look_down_angle = -80
@export var max_tilt_angle = 55.0

var camera_pitch = 0
var camera_tilt = 0
var mode: MODE = MODE.PC
var isDragging = false

func _ready():
	setMode(MODE.PC)
	
func setMode(givenMode: MODE):
	mode = givenMode
	if mode == MODE.PC:
		if ui:
			ui.setUIMode(MODE.PC)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		if ui:
			ui.setUIMode(MODE.MOBILE)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("change_mode"):
			setMode(MODE.MOBILE if mode == MODE.PC else MODE.PC)
	if event is InputEventMouseMotion:
		if mode == MODE.PC or (isDragging and not MovementJoystick.isMoving):
			camera_pitch += -event.relative.y * sensitivity
			camera_pitch = clamp(camera_pitch, max_look_down_angle, max_look_up_angle)
			rotation_degrees.x = camera_pitch

			if Player:
				Player.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
				camera_tilt = clamp(event.relative.x * sensitivity * 0.1, -max_tilt_angle, max_tilt_angle)
			if SpotLight:
				SpotLight.rotation_degrees.x = camera_pitch
				
	if event is InputEventMouseButton:
		if event.pressed:
			isDragging = true
		else:
			isDragging = false

func _process(delta):
	rotation_degrees.z = lerp(rotation_degrees.z, camera_tilt * 7 * 1.0, delta*10)
	camera_tilt = 0.0
