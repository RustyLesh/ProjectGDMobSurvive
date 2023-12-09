extends Button
class_name GearSlot

signal on_gear_selected(gear:Gear)
signal on_gear_slot_clicked(gear_type: Gear.GearType)

@export var equiped_gear: Gear
@export var gear_slot_type: Gear.GearType

func init_gear_slot(gear_slot: Gear.GearType):
	gear_slot_type = gear_slot
	
func equip_gear(gear: Gear):
	equiped_gear = gear
	icon = gear.icon

func _on_pressed():
	if equiped_gear != null:
		on_gear_selected.emit(equiped_gear)
	on_gear_slot_clicked.emit(gear_slot_type)
