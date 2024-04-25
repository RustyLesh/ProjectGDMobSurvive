class_name DropGearResource extends DropResource
## Spawns a gear pickup instance. To be used with a [DropPool]

@export var gear_resource: GearResource
var drop_colours: DropColours

func _init():
	drop_type = DropType.GEAR
	drop_node = preload("res://gear_drop.tscn")
	drop_colours = preload("res://Resources/drop_colours.tres")

func init_gear_drop(gear_drop: GearDrop):
	gear_drop.modulate = drop_colours.colours_array[rarity]
	gear_drop.gear_resource = gear_resource

