extends ScrollButton
class_name InventoryItemButton

@export var gear: Gear
@export var id: int

signal gear_bubtton_pressed(id: int)

func _on_scroll_button_pressed():
	gear_bubtton_pressed.emit(id)
