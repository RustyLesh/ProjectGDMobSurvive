extends HBoxContainer
class_name SaveTest

@onready var button_array
@onready var test_data: TestData = $"../Test Data"
@onready var options = $".."

func _ready():
	button_array = get_children(false)
	for i in button_array.size():
		button_array[i].number = i
		button_array[i].on_test_pressed.connect(test_button_pressed)

func test_button_pressed(number: int):
	test_data.number_array[number] += 1
	options.update_ui()
	
