extends HBoxContainer
class_name SaveTest

@onready var button_array
@onready var test_data: TestData = $"../Test Data"
@onready var options = $".."

func test_button_pressed(number: int):
	test_data.number_array[number] += 1
	options.update_ui()
	
