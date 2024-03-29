extends Resource
class_name Stat
#Stores modifiers and calculates a single value from the modifiers based on thier type.
signal on_value_changed(value)

#whenever a mod is added or removed it is set as dirty. when getting value, if is_dirty is true, 
#value will be calculated from stat_mod_container and is_dirty set to false
var is_dirty = true

#stores stat modifers
@export var stat_mod_container : Array[StatMod] = []

@export var value : float:
	get: 
		if is_dirty:
			stat_mod_container.sort_custom(sort_by_type)
			calculate_value()
		return value

#Adds statmod to stat mod container
func apply_stat(stat_mod : StatMod):
	is_dirty = true
	stat_mod_container.append(stat_mod)
	on_value_changed.emit(value)

#Calculates the final value from the stat mods container
func calculate_value():
	var temp_value = 0
	for stat_mod in stat_mod_container:
		match stat_mod.stat_mod_type:
			StatMod.StatModType.FLAT:
				temp_value += stat_mod.value
			StatMod.StatModType.MULTIPLIER:
				temp_value *= 1 + (stat_mod.value / 100)
	value = temp_value
	is_dirty = false

#sorts it so flat modifiers are first and multipliers are second
func sort_by_type(a, b):
	if a.stat_mod_type < b.stat_mod_type:
		return true
	return false

#remove stat that is from given source
func remove_stat(source: GearResource.GearType):
	is_dirty = true
	for stat_mod in stat_mod_container:
		if stat_mod.source == source:
			stat_mod_container.erase(stat_mod)
			return

func get_string() -> String:
	return "empty"
