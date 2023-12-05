extends MarginContainer
class_name EquipedGearMenu

@onready var helmet_slot: GearSlot = $GearUIContainer/Helmet
@onready var ring_slot: GearSlot = $GearUIContainer/Ring
@onready var amulet_slot: GearSlot = $GearUIContainer/Amulet

func equip_gear(gear: Gear) -> Gear:
	var return_gear
	match gear.gear_type:
		Gear.GearType.HELMET:
			return_gear = helmet_slot.equiped_gear
			helmet_slot.equip_gear(gear)
		
		Gear.GearType.AMULET:
			return_gear = amulet_slot.equiped_gear
			amulet_slot.equip_gear(gear)
		
		Gear.GearType.RING:
			return_gear = ring_slot.equiped_gear
			ring_slot.equip_gear(gear)
			
	return return_gear

