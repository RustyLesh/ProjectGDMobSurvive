extends Button
class_name SkillTreeButton
var tree_mod: GearModifier

@onready var parent_tree_panel = get_parent().get_parent()

signal on_skill_tree_pressed(gear_modifier: GearModifier, panel_index: int, button_index: int)

func _init():
	if tree_mod != null:
		tree_mod.set_source_type(GearResource.GearType.SKILL_TREE)

func _pressed():
	on_skill_tree_pressed.emit(tree_mod, parent_tree_panel.get_index(), get_index())
