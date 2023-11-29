extends Resource
class_name StatMod

enum StatModType
{
	FLAT,
	MULTIPLIER, ## Percent Multplier
}

@export var stat_mod_type: StatModType
@export var value: float = 0
@export var source: Resource
