extends DropResource
class_name DropGearResource

@export var gear_resource: GearResource

func _init():
	drop_type = DropType.GEAR
	drop_node = preload("res://gear_drop.tscn")

