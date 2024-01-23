extends Stat
class_name BaseStat
#Main stats for player
enum BaseStatType
{
	MAX_LIFE,
	DAMAGE,
	FIRE_RATE,
	MOVEMENT_SPEED,
	PROJ_COUNT, #Extra pojectiles 
	BULLET_LIFE_TIME,
	PIERCE,
	COUNT
}

@export var base_type: BaseStatType

func apply_stat(stat_mod : StatMod):
	is_dirty = true
	stat_mod_container.append(stat_mod)
	on_value_changed.emit(value)

func get_string() -> String:
	return str(value, " ", BaseStatType.keys()[base_type])

func get_save_data():
	var stat_mod_dict= []
	for stat_mod in stat_mod_container:
		stat_mod_dict.append(stat_mod.get_save_data())

	return{
		"base_type": base_type,
		"is_dirty": is_dirty,
		"stat_mod_container": stat_mod_container,
		"value": value,
	}

func set_resource_data(data_dict):
	base_type = data_dict["base_type"]
	is_dirty = data_dict["is_dirty"]
	value = data_dict["value"]

	var stat_mod_container_data = data_dict["stat_mod_container"]
	for stat_mod_data in stat_mod_container_data:
		var new_stat_mod = StatMod.new()
		new_stat_mod.set_resource_data(stat_mod_data)
		stat_mod_container.append(new_stat_mod)
