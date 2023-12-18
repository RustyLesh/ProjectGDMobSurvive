extends  Resource
class_name Gear
#Base for equippable items

enum GearType
{
	HELMET,
	RING,
	AMULET,
}

@export var name: String
@export var description: String
@export var icon: Texture2D
@export var gear_type: GearType

@export var mod_list: Array[GearModifier]

