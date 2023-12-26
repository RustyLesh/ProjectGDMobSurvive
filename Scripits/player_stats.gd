extends Node

var weapon_xp: float

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
	