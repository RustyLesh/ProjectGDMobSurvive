extends Upgrade
class_name BaseStatUpgrade
#Upgrade to modify a base stat

@export var _value: float
@export var _mod_type: StatMod.StatModType
@export var _base_stat_type: BaseStat.BaseStatType

func _init():
	base_res_path = "res://Resources/Upgrades/Base Stat Upgrades/base_stat_upgrade.tres"

func apply_upgrade(player: Node):
	var statmod := StatMod.new()
	statmod.value = _value
	statmod.stat_mod_type = _mod_type
	statmod.source = GearResource.GearType.UPGRADE
	var player_stat_container = player.combat_stat_container
	if player_stat_container is StatContainer:
			player_stat_container.add_mod_to_base_stat(statmod, _base_stat_type)

func apply_upgrade_main_menu(player_stat_container: StatContainer, gear_type: GearResource.GearType):
	var statmod := StatMod.new()
	statmod.value = _value
	statmod.stat_mod_type = _mod_type
	statmod.source = gear_type
	
	if player_stat_container is StatContainer:
		player_stat_container.add_mod_to_base_stat(statmod, _base_stat_type)
	
func remove_upgrade(stat_container: StatContainer, gear_type: GearResource.GearType):
	if stat_container is StatContainer:
		stat_container.remove_mod_from_base_stat(_base_stat_type, gear_type)

func get_upgrade_string() -> String:
	var return_string
	if _value >= 0:
		return_string = "+"
	else:
		return_string = "-"
	
	return_string += str(_value)
	
	if _mod_type == StatMod.StatModType.MULTIPLIER:
		return_string += "%"
		
	return_string += str(" ", BaseStat.BaseStatType.keys()[_base_stat_type])
	return return_string

func get_save_data() -> Dictionary:
	return{
		"value": _value,
		"mod_type": _mod_type,
		"base_stat_type": _base_stat_type,
		"resource_path": base_res_path,
	}

func set_resource_data(data_dict):
	_value = data_dict["value"]
	_mod_type = data_dict["mod_type"]
	_base_stat_type = data_dict["base_stat_type"]
