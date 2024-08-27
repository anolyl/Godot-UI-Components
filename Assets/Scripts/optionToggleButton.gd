extends Control

@onready var toggle = $toggle
@onready var color = $toggle/color

var toggled = false

func _on_toggle_pressed():
	toggled = not toggled
	if toggled:
		color.modulate = Color("ff917a")
	else:
		color.modulate = Color("74ce51")
