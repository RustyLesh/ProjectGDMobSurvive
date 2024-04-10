extends Node
#Stores player data for going between main menu and combat levels
@export var selected_weapon_index: int = -1
@export var weapon: WeaponResource

@export var weapon_storage: Array[WeaponResource]

@export var upgrade_pool: Array[UpgradeResource]
@export var selected_upgrades: Array[UpgradeResource]
@export var base_stats: Array[BaseStat]

@export var gear_drops: Array[GearResource]
@export var inventory: Array[GearResource]
@export var equiped_gear: Array[GearResource]

@export var enemy_spawns: EnemySpawns
@export var difficulty: int

const FILE_NAME = "user://player_setup.save"

func end_of_stage():
	inventory.append_array(PlayerSetup.gear_drops)
	gear_drops.clear()

func save():
	print("player setup saved")
	var upgrade_pool_data = []
	var selected_upgrades_data = []
	var inv_dict: Array[Dictionary]
	var equiped_gear_data = []
	var weapon_storage_data = {}

	for upgrade in upgrade_pool:
		upgrade_pool_data.append(upgrade.get_save_data())

	for upgrade in selected_upgrades:
		selected_upgrades_data.append(upgrade.get_save_data())

	for gear in inventory:
		inv_dict.append(gear.get_save_data())
	
	for gear in equiped_gear:
		equiped_gear_data.append(gear.get_save_data())

	for wep_res in weapon_storage:
		var wep_data = wep_res.get_save_data()
		weapon_storage_data[wep_data["weapon_name"]] = wep_data["data_dict"]

	var save_dict = {
		"inventory": inv_dict,
		"selected_weapon_index": selected_weapon_index,
		"upgrade_pool": upgrade_pool_data,
		"weapon_storage": weapon_storage_data,
		"select_upgrades": selected_upgrades_data,
		"equiped_gear": equiped_gear_data,
	}

	return {
		"file_name": FILE_NAME,
		"data": save_dict,
	}

func load_data():
	var data = SaveManager.load_file(FILE_NAME)
	var inv_data = data["inventory"]
	var upgrade_pool_data = data["upgrade_pool"]
	var selected_upgrades_data = data["select_upgrades"]
	var weapon_storage_data = data["weapon_storage"]
	var equiped_gear_data = data["equiped_gear"]
	var weapon_data_dict = {}

	for item in inv_data:
		var new_gear = GearResource.new()
		new_gear.set_resource_data(item)
		inventory.append(new_gear)

	for item in equiped_gear_data:
		var new_gear = GearResource.new()
		new_gear.set_resource_data(item)
		equiped_gear.append(new_gear)

	for upgrade in upgrade_pool_data:
		var new_upgrade = UpgradeResource.new()
		new_upgrade.set_resource_data(upgrade)
		upgrade_pool.append(new_upgrade)

	for upgrade in selected_upgrades_data:
		var new_upgrade = UpgradeResource.new()
		new_upgrade.set_resource_data(upgrade)
		selected_upgrades.append(new_upgrade)
	
	for weapon_data in weapon_storage:
		var wep_data_dict = weapon_storage_data[weapon_data.weapon_name]
		weapon_data.set_resource_data(wep_data_dict)

	selected_weapon_index = data["selected_weapon_index"]
