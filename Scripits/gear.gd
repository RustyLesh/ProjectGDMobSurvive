extends Resource
class_name GearResource
#Base for equippable items

enum GearType
{
	HELMET,
	RING,
	AMULET,
	WEAPON,
	UPGRADE,
	SKILL_TREE,
	BASE,
	SPECIALIZATION,
}

@export var _item_name: String
@export var _description: String
@export var _icon: Texture2D = load("res://Art/no_icon.png")
@export var _gear_type: GearType

@export var mod_list: Array[GearModifier]

func get_save_data() -> Dictionary:
	var mod_list_dict = []
	for mod in mod_list:
		mod_list_dict.append(mod.get_save_data())
	return {
		"item_name": _item_name,
		"description": _description,
		"icon_path": _icon.resource_path,
		"gear_type": _gear_type,
		"mod_list": mod_list_dict,
	}

func set_resource_data(data_dict):
	_item_name = data_dict["item_name"]
	_description = data_dict["description"]
	_icon = load(data_dict["icon_path"])
	_gear_type = data_dict["gear_type"]
	var mod_list_data = data_dict["mod_list"]
	
	for mod_data in mod_list_data:
		var gear_mod = GearModifier.new()
		gear_mod.set_resource_data(mod_data)
		mod_list.append(gear_mod)

func init_gear_drop():
	for mod in mod_list:
		mod.init_gear_mod(_gear_type)
