extends Resource
class_name WeaponXpTree

var base_res_path: String

@export var weapon_level: int
@export var level_1: Array[GearModifier]
@export var level_2: Array[GearModifier]
@export var level_3: Array[GearModifier]
@export var level_4: Array[GearModifier]
@export var level_5: Array[GearModifier]

@export var tree_dict = {}
@export var selected = {}

func init_weapon_tree():
	tree_dict[0] = level_1
	tree_dict[1] = level_2
	tree_dict[2] = level_3
	tree_dict[3] = level_4
	tree_dict[4] = level_5

func get_saved_data():
	print("selected save dict: ", selected)
	return {
		"selected": selected,
	}

func set_resource_data(data_dict):
	var selected_data = data_dict["selected"]
	print("tree int: ", selected_data.size())
	for entry in selected_data.keys():
		selected[int(entry)] = selected_data[entry]
