extends Button
class_name GearSlot

@export var equiped_gear: Gear

func equip_gear(gear: Gear):
	equiped_gear = gear
	icon = gear.icon

