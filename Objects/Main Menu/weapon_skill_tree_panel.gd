extends Panel
class_name WeaponSkillTreePanel

@onready var h_box: HBoxContainer = $HBoxContainer

func deselect_other_nodes(selected_index: int):
	print("Deselecting nodes func")
	var children = h_box.get_children()
	for node in children:
		if node is Button:
			if node.get_index() != selected_index:
				node.button_pressed = false
