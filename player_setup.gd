extends Node
#Stores player data for going between main menu and combat levels

@export var weapon: WeaponResource

@export var upgrade_pool: Array[UpgradeResource]
@export var base_stats: Array[BaseStat]

@export var inventory: Array[GearResource]
@export var gear_drops: Array[GearResource]

const FILE_NAME = "user://player_setup.save"

func remove_upgrades_by_source(slot_type: GearResource.GearType):
	var remove_pool: Array[UpgradeResource]
	for upgrade in upgrade_pool:
		if upgrade.source_type == slot_type:
			remove_pool.append(upgrade)
	
	for upgrade in remove_pool:
		upgrade_pool.erase(upgrade)
			
func save():
	var inv_dict: Array[Dictionary]

	for gear in inventory:
		inv_dict.append(gear.get_save_data())
		
	var save_dict = {"inventory": inv_dict}

	return {
		"file_name": FILE_NAME,
		"data": save_dict,
	}
	
func load_data():
	var data = SaveManager.load_file(FILE_NAME)
	print(data)
	var inv_data = data["inventory"]
	for item in inv_data:
		var new_gear = GearResource.new()
		new_gear.set_resource_data(item)
		inventory.append(new_gear)
