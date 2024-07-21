extends Resource
class_name UpgradeResource

@export var _name: String
@export var _description: String
@export var _icon : Texture2D = load("res://Art/no_icon.png")

@export var upgrades: Array[Upgrade]
@export var added_upgrades: Array[UpgradeResource]
@export var _max_uses: int
@export var weight: int

var forced_upgrade: bool
var source_type: GearResource.GearType
var marked_for_removal := false
var current_uses: int = 0

func get_save_data() -> Dictionary:
	var upgrades_data = []
	for upgrade_data in upgrades:
		upgrades_data.append(upgrade_data.get_save_data())	

	var added_uprades_data = []
	for upgrade_data in added_upgrades:
		added_uprades_data.append(upgrade_data.get_save_data())

	return {
		"name": _name,
		"description": _description,
		"icon": _icon.resource_path,
		"upgrades_data": upgrades_data,
		"added_uprades_data": added_uprades_data,
		"max_uses": _max_uses,
		"source_type": source_type,
		"forced_upgrade": forced_upgrade
	}

func set_resource_data(data_dict):
	_name = data_dict["name"]
	_description = data_dict["description"]
	_icon  = load(data_dict["icon"])
	_max_uses = data_dict["max_uses"]
	var upgrades_data_array = data_dict["upgrades_data"]
	for upgrade_data in upgrades_data_array:
		var data = load(upgrade_data["base_res_path"]).duplicate()
		data.set_resource_data(upgrade_data)
		upgrades.append(data)

	var added_upgrades_array = data_dict["added_uprades_data"]
	for added_upgrade in added_upgrades_array:
		var upgrade_resource = UpgradeResource.new()
		upgrade_resource.set_resource_data(added_upgrade)
		added_upgrades.append(upgrade_resource)

	forced_upgrade = data_dict["forced_upgrade"]

	source_type = data_dict["source_type"]
