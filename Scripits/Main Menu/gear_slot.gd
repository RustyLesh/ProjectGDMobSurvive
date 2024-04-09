extends Button
class_name GearSlot

signal on_gear_selected(gear:GearResource)
signal on_empty_slot_selected()
signal on_gear_slot_clicked(gear_type: GearResource.GearType)

@export var equiped_gear: GearResource
@export var gear_slot_type: GearResource.GearType

#Assign gear type to a slot
func init_gear_slot(gear_slot: GearResource.GearType):
	gear_slot_type = gear_slot
	
func equip_gear(gear: GearResource):
	equiped_gear = gear
	icon = gear._icon

func _on_pressed():
	on_gear_slot_clicked.emit(gear_slot_type)
	
	if equiped_gear == null:
		on_empty_slot_selected.emit()
		return

	on_gear_selected.emit(equiped_gear)