extends Panel
class_name WeaponSkillTreePanel

@onready var child_nodes = $HBoxContainer.get_children()

var selected_index: int
var button_instance: = preload("res://skill_tree_skill_button.tscn")
var slot_modifers: Array[GearModifier]

func init_panel(callable: Callable):
	for node in child_nodes:
		node.on_skill_tree_pressed.connect(callable)

func deselect_other_nodes(_selected_index: int):
	selected_index = _selected_index
	print("Deselecting nodes func")

	for node in child_nodes:
		if node is Button:
			if node.get_index() != selected_index:
				node.button_pressed = false

func get_selected_node_gear_resource() -> GearModifier:
	return  child_nodes[selected_index].tree_mod

func clear_panel():
	for child in child_nodes:
		child.visible = false

func select_node(index: int):
	deselect_other_nodes(index)
	child_nodes[index].set_pressed_no_signal(true)

	return slot_modifers[index]

func update_panel(modifiers: Array[GearModifier], selected_node: int):
	visible = true
	slot_modifers = modifiers
	for i in modifiers.size():
		child_nodes[i].init_button(modifiers[i])
		child_nodes[i].visible = true
	
	if selected_node >= 0:
		child_nodes[selected_node].set_pressed_no_signal(true)

