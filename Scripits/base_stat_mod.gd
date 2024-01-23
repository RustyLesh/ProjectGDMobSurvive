extends Resource
class_name BaseStatMod

@export var base_stat_type: BaseStat.BaseStatType
@export var value: float
@export var stat_mod_type: StatMod.StatModType
@export var source_type: GearResource.GearType

func get_stat_mod() -> StatMod:
	var new_mod = StatMod.new()
	new_mod.value = value
	new_mod.stat_mod_type = stat_mod_type
	new_mod.source = source_type
	return new_mod

func get_string():
	var return_str = ""
	if stat_mod_type == StatMod.StatModType.FLAT:
		return_str += str("+", value, " ")
	else:
		return_str += str("+", value, "% ")

	return_str += str(BaseStat.BaseStatType.keys()[base_stat_type])
	return return_str

func apply_mod_main_menu(stat_container: MainMenuStatContainer):
	stat_container.add_mod_to_base_stat(get_stat_mod(), base_stat_type)

func apply_mod_in_combat(combat_stat_container: StatContainer):
	if combat_stat_container is StatContainer:
		combat_stat_container.add_mod_to_base_stat(get_stat_mod(), base_stat_type)

func remove_mod(stat_container: MainMenuStatContainer, gear_type: GearResource.GearType):
	stat_container.remove_mod_from_base_stat(base_stat_type, gear_type)