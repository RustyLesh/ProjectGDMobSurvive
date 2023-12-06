extends Resource
class_name GearModifier

enum GearModType
{
	APPLY_NOW,
	ADD_TO_COMBAT_POOL
}

@export var mod_type: GearModType
@export var upgrade: UpgradeResource

var source


