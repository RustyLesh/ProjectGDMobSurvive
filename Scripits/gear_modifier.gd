extends Resource
class_name GearModifier

enum GearModType
{
	STAT_MOD,
	UPGRADE,
}

@export var upgrade: UpgradeResource
@export var stat_mod: StatMod

var source


