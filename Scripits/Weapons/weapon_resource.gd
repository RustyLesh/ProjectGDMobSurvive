extends Resource
class_name WeaponResource
#Holds data for player weapon

@export var icon: CompressedTexture2D
@export var weapon_name: String
@export var description: String
@export var weapon: Resource
@export var upgrades: Array[UpgradeResource]
@export var specializations: Array[UpgradeResource]
@export var weapon_xp: int
@export var level: int:
	get:
		return xp_constant * sqrt(weapon_xp)

@export var weapon_tree: WeaponXpTree
@export var unlocked: bool
@export var base_stat_mods: Array[BaseStatMod]
var base_stats: Array[BaseStat]

var xp_constant: float = 0.5

var max_level = 5

func _init():
	for upgrade in upgrades:
		upgrade.source_type = GearResource.GearType.WEAPON

	for base_stat in base_stat_mods:
		base_stats.append(base_stat.get_stat_mod())

func get_current_xp():
	if level == 0:
		return weapon_xp
		
	return weapon_xp - (pow(((level - 1) / xp_constant ), 2))

func get_xp_for_next_level():
	return  pow(((level + 1) / xp_constant ), 2)

func get_save_data():
	var data_dict = {
		"weapon_xp": weapon_xp,
		"unlocked": unlocked,
		"weapon_tree": weapon_tree.get_saved_data(),
	}
	return {
		"weapon_name": weapon_name,
		"data_dict": data_dict,
	}

func set_resource_data(data_dict):
	weapon_xp = data_dict["weapon_xp"]
	unlocked = data_dict["unlocked"]
	weapon_tree.set_resource_data(data_dict["weapon_tree"])
