extends Node

var weapon_xp: int

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"node_name" : name,
		"weapon_xp" : weapon_xp
	}
	return save_dict

func load_data(dictionary):
	weapon_xp = dictionary["weapon_xp"]
	
#func save():
#	var save_dict = {
#		"filename" : get_scene_file_path(),
#		"parent" : get_parent().get_path(),
#		"node_name" : name,
#		"value_array" : number_array
#	}
#	return save_dict
#
#func load_data(dictionary):
#	print("load data")
#	number_array = dictionary["value_array"].duplicate()
#	options.update_ui()
