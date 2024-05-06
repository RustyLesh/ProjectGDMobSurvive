extends Node

signal on_key_board_and_mouse_input()
signal on_controller_input()

var controller_was_used_last: bool = false

func _input(event):
	
	if event.is_action_pressed("ui_accept"):
		print("select pressed")
		var selected_control = get_viewport().gui_get_focus_owner()
		if selected_control is Button:
			if selected_control.disabled:
				return
			selected_control.pressed.emit()
	
	if event is InputEventMouseButton || event is InputEventMouseMotion:
		on_key_board_and_mouse_input.emit()
		controller_was_used_last = false
	
	if event is InputEventJoypadButton || event is InputEventJoypadMotion:
		on_controller_input.emit()
		controller_was_used_last = true

	if event.is_action_pressed("shoot"):
		if get_viewport().gui_get_focus_owner() != null:
			print("currently foccused: ", get_viewport().gui_get_focus_owner().name)
		else:
			print("currently foccused: null")

