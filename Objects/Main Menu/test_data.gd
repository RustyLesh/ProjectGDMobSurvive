extends Node
class_name TestData

var number_array = [0, 0, 0, 0]
@onready var options = $".."

func _ready():
	await get_tree().create_timer(.001).timeout

	options.update_ui()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"node_name" : name,
		"value_array" : number_array
	}
	return save_dict

func load_data(dictionary):
	print("load data")
	number_array = dictionary["value_array"].duplicate()
	options.update_ui()
