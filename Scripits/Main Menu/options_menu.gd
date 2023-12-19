extends Control
class_name OptionsMenu

#Save Load
@onready var save_manager: SaveManager = $"../Save Manager"
@onready var save_button: Button = $Save
@onready var load_button: Button = $Load

#TEST DATA save load testing
@onready var test_data_label: Label = $Label

func update_ui():
	var test_data_node = $"Test Data"
	await get_tree().create_timer(.001).timeout
	print("update ui")
	if not FileAccess.file_exists("user://savegame.save"):
		load_button.disabled = true
	else:
		load_button.disabled = false
	
	test_data_label.text = ""
	for number in test_data_node.number_array:
		test_data_label.text += str(number, "\n")
	
func _on_save_pressed():
	save_manager.save_game()
	update_ui()

func _on_load_pressed():
	save_manager.load_game()
