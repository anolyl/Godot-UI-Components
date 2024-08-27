extends Panel

@export var pages : Array[Panel] = []
@onready var pages_listing_container = $pagesListingContainer
@onready var currentPage = 1
var target_position: Vector2
var transition_speed: float = 5.0

func _ready():
	target_position = pages[currentPage - 1].position
	update_target_positions()

func _process(delta):
	var count = pages_listing_container.get_child_count() + 1
	for iL in range(count):
		if currentPage == iL:
			var paging = pages_listing_container.get_children()[iL - 1]
			paging.modulate = Color(1,1,1,1)
		else:
			var paging = pages_listing_container.get_children()[iL - 1]
			paging.modulate = Color(1,1,1,.15)
	for i in range(pages.size()):
		pages[i].position = pages[i].position.lerp(target_position_for_page(i), transition_speed * delta)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			go_to_previous_page()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			go_to_next_page()

func go_to_previous_page():
	if currentPage > 1:
		currentPage -= 1
		update_target_positions()

func go_to_next_page():
	if currentPage < pages.size():
		currentPage += 1
		update_target_positions()

func update_target_positions():
	for i in range(pages.size()):
		pages[i].position = target_position_for_page(i)

func target_position_for_page(index):
	var offset = (currentPage - 1) * pages[0].size.y
	return Vector2(0, index * pages[index].size.y - offset)
