extends Panel
class_name WeaponSkillTreeMenu

@onready var stat_container: StatContainer = $"../../Stat Container"
@onready var upgrade_menu = $"../../Upgrade Menu"
var tree_panels = []
var button_instance = preload("res://skill_tree_skill_button.tscn")

func _ready():
	tree_panels = get_node("VBoxContainer").get_children()

func update_ui(weapon: WeaponResource):
	var weapon_tree = weapon.weapon_tree
	weapon_tree.init_weapon_tree()
	for tree_i in tree_panels.size():
		for mod_index in weapon_tree.tree_array[tree_i].size():
			var tree_option = button_instance.instantiate()
			tree_option.on_skill_tree_pressed.connect(apply_tree_node)
			tree_panels[tree_i].get_child(0).add_child(tree_option)
			tree_option.tree_mod = weapon_tree.tree_array[tree_i][mod_index]
			tree_option.icon = weapon_tree.tree_array[tree_i][mod_index].upgrade_resource._icon

func close_tree():
	visible = false

func apply_tree_node(tree_mod: GearModifier, panel_index: int, selected_index: int):
	if tree_mod == null:
		return
		
	print("index", panel_index)
	tree_panels[panel_index].deselect_other_nodes(selected_index)

	#Remove all existing skill tree mods if any
	stat_container.remove_all_stats_based_on_source(GearResource.GearType.SKILL_TREE)
	upgrade_menu.remove_upgrades_by_source(GearResource.GearType.SKILL_TREE)
		
	#Apply mods from selected skill
	tree_mod.set_source_type(GearResource.GearType.SKILL_TREE)
	if tree_mod.mod_type == GearModifier.GearModType.APPLY_NOW:
		tree_mod.upgrade_resource.upgrade.apply_upgrade_main_menu(stat_container, GearResource.GearType.SKILL_TREE)
	else: if tree_mod.mod_type == GearModifier.GearModType.ADD_TO_COMBAT_POOL:
		upgrade_menu.upgrade_pool.append(tree_mod.upgrade_resource.upgrade)
