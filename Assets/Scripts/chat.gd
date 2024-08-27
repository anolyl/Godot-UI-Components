extends Panel
@onready var input = $Input
@onready var v_box_container = $container/VBoxContainer

var text = ""
var focused = false

@export var isMobile = false

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_T and not isMobile:
				focused = true
				await get_tree().create_timer(0.05).timeout
				input.grab_focus()
			if event.keycode == KEY_ENTER:
				if text == "":
					return
				var label = Label.new()
				label.text = "User: " + text
				label.modulate = Color(1,1,1,1)
				label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
				v_box_container.add_child(label)
				input.clear()
				input.release_focus()
				text = ""
				focused = false
				pass
				
func _on_input_text_changed():
	if focused == true:
		text = input.text
	else:
		input.clear()

func _on_input_focus_entered():
	focused = true

func _on_input_focus_exited():
	focused = false
