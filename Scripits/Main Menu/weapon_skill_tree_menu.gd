extends Panel
class_name WeaponSkillTreeMenu

@onready var stat_container: StatContainer = $"../../Stat Container"
@onready var upgrade_menu = $"../../Upgrade Menu"
@onready var info_panel = $"Tree Info"
@onready var apply_node_button = $Apply
@onready var tree_panels = get_node("VBoxContainer").get_children()
var selected_weapon

var selected_panel_index
var selected_node_index
var selected_tree_mod

func _ready():
	await get_tree().create_timer(.5).timeout
	if PlayerSetup.weapon != null:	

		selected_weapon = PlayerSetup.weapon
		var selected_weapon_tree = selected_weapon.weapon_tree
		for selected_panel in selected_weapon_tree.selected.keys():
			var selected_node = selected_weapon_tree.selected[selected_panel]
			var selected_panel_array = selected_weapon_tree.tree_dict[selected_panel]
			var gear_mod = selected_panel_array[selected_node]
			apply_loaded_skill_tree(gear_mod, selected_panel, selected_node)

func on_weapon_select(weapon: WeaponResource):
	for panel in tree_panels:
		panel.clear_panel()
	
	var skill_tree = weapon.weapon_tree
	var tree_dict = skill_tree.tree_dict

	for index in tree_panels.size():
		if !tree_dict.has(index): #If entry in dict doesnt exist, skip to avoid index error on dict
			tree_panels[index].visible = false
			continue

		if index >= tree_dict.size() || tree_dict[index].is_empty():
			tree_panels[index].visible = false
		else:
			if skill_tree.selected.has(index):
				tree_panels[index].update_panel(tree_dict[index], skill_tree.selected[index])
			else:
				tree_panels[index].update_panel(tree_dict[index], -1)

	selected_weapon = weapon

	for panel_index in tree_panels.size():
		tree_panels[panel_index].init_panel(tree_node_selected)
		if (PlayerStats.highest_stage_completed - 1) < panel_index:
			tree_panels[panel_index].disable_all_options()
			

func close_tree():
	visible = false

func tree_node_selected(tree_mod: GearModifier, panel_index: int, selected_index: int):
	var upgrade_resource = tree_mod.upgrade_resource
	info_panel.update_ui(upgrade_resource)
	selected_panel_index = panel_index
	selected_node_index = selected_index
	selected_tree_mod = tree_mod
	tree_panels[selected_panel_index].deselect_other_nodes(selected_node_index)
	apply_node_button.disabled = false
func apply_selected_tree_node():
	selected_weapon.weapon_tree.selected[selected_panel_index] = selected_panel_index
	if selected_tree_mod == null:
		return

	#Remove all existing skill tree mods if any
	var selected_panel = tree_panels[selected_panel_index]

	if selected_panel.get_selected_node_gear_resource().mod_type == GearModifier.GearModType.APPLY_NOW:
		stat_container.remove_all_stats_based_on_source(GearResource.GearType.SKILL_TREE)
	else:
		upgrade_menu.remove_upgrades_by_source(GearResource.GearType.SKILL_TREE)
	
	#Apply mods from selected skill
	selected_tree_mod.set_source_type(GearResource.GearType.SKILL_TREE)
	if selected_tree_mod.mod_type == GearModifier.GearModType.APPLY_NOW:
		selected_tree_mod.upgrade_resource.upgrade.apply_upgrade_main_menu(stat_container, GearResource.GearType.SKILL_TREE)
	else: if selected_tree_mod.mod_type == GearModifier.GearModType.ADD_TO_COMBAT_POOL:
		upgrade_menu.upgrade_pool.append(selected_tree_mod.upgrade_resource)

func apply_loaded_skill_tree(tree_mod: GearModifier, panel_index: int, selected_index: int):
	selected_weapon.weapon_tree.selected[panel_index] = selected_index
	if tree_mod == null:
		return

	#Apply mods from selected skill
	tree_mod.set_source_type(GearResource.GearType.SKILL_TREE)
	if tree_mod.mod_type == GearModifier.GearModType.APPLY_NOW:
		tree_mod.upgrade_resource.upgrade.apply_upgrade_main_menu(stat_container, GearResource.GearType.SKILL_TREE)
	else: if tree_mod.mod_type == GearModifier.GearModType.ADD_TO_COMBAT_POOL:
		upgrade_menu.upgrade_pool.append(tree_mod.upgrade_resource)
