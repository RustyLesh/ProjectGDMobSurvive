extends Button
class_name SaveTestButton

var number: int
signal on_test_pressed(number: int)
func _ready():
	pressed.connect(on_button_pressed)

func on_button_pressed():
	on_test_pressed.emit(number)
