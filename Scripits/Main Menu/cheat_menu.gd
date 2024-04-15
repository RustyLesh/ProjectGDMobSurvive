extends Control

#Give Gear
@onready var gear_menu:GearMenu = %"Gear Menu"
@export var gear_to_give: Array[GearResource]


func _on_give_gear_pressed():
	for gear in gear_to_give:
		gear_menu.add_item(gear)

