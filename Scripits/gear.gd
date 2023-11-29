extends  Resource
class_name Gear

enum GearType
{
	HELMET,
	RING,
	AMULET,
}

@export var name: String
@export var description: String
@export var icon: Texture2D

@export var mod_list: Array[GearModifier]

