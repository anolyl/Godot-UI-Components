extends VBoxContainer

func log(text: String):
	var label = Label.new()
	label.text = text
	label.modulate = Color(1,1,1,0.2)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	add_child(label)
	await get_tree().create_timer(4.0).timeout
	label.queue_free()
