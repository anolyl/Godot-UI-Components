extends Control

@export var buttonsToHide : Array[Button] = []

var vector: Vector3
var isMoving: bool = false

func hideObstructiveButtons(hide: bool):
	if hide:
		for button in buttonsToHide:
			button.modulate = Color(1, 1, 1, .1)
	else:
		for button in buttonsToHide:
			button.modulate = Color(1, 1, 1, 1)
