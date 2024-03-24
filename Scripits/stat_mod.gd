extends Resource
class_name StatMod
#Moidifer to be stored in a Stat resource

enum StatModType
{
	FLAT,
	MULTIPLIER, ## Percent Multplier
}

@export var stat_mod_type: StatModType
@export var value: float = 0
@export var source: GearResource.GearType
@export var force_equip: bool

func get_save_data():
	return{
		"stat_mod_type": stat_mod_type,
		"value": value,
		"source": source,
	}

func set_resource_data(data_dict):
	stat_mod_type = data_dict["stat_mod_type"]
	value = data_dict["value"]
	source = data_dict[source]