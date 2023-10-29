extends Resource
class_name Stat

signal on_value_changed(value)

@export var stat_mod_container : Array[StatMod] = []
		
@export var value : float:
	get: 
		if is_dirty:
			stat_mod_container.sort_custom(sort_by_type)
			calculate_value()
		return value

var is_dirty = true

func apply_stat(stat_mod : StatMod):
	is_dirty = true
	stat_mod_container.append(stat_mod)
	on_value_changed.emit(value)

func calculate_value():
	var temp_value = 0
	for stat_mod in stat_mod_container:
		match stat_mod.stat_mod_type:
			StatMod.StatModType.FLAT:
				temp_value += stat_mod.value
			StatMod.StatModType.MULTIPLIER:
				temp_value *= stat_mod.value
	value = temp_value
	is_dirty = false

func sort_by_type(a, b):
	if a.stat_mod_type < b.stat_mod_type:
		return true
	return false
