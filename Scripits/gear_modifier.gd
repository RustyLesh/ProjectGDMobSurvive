extends Resource
class_name GearModifier

enum GearModType
{
	APPLY_NOW,
	APPLY_IN_COMBAT
}

@export var mod_type: GearModType
@export var upgrade: UpgradeResource

var source


