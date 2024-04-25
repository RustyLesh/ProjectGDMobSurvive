extends Control
class_name GearMenu

@onready var upgrade_menu: UpgradeManageMenu = $"../Upgrade Menu"
@onready var item_list: ItemList = $"ScrollContainer/Item List"
@onready var selected_info_box: SelectedItemInfo = $"Item Info"
@onready var equiped_gear_menu: EquipedGearMenu = $"../Equiped Gear Menu"
@onready var stat_container: StatContainer = $"../Stat Container"
@onready var selected_item_options: HBoxContainer = $"Selected Item Options"
@onready var no_results_warning: Label = $"No Results Warning"
@onready var no_gear_warning: Label = $"No Gear Warning"
var inv_item_button: Resource = preload("res://Objects/Main Menu/inventory_item.tscn")

var gear_list_filtered: Array[GearResource]
var gear_list: Array[GearResource]
var filter_applied: bool

@export var selected_item: int = -1
@export var is_equiped_item_selected: bool

func _ready():
	InputManager.on_controller_input.connect(on_controller_input)
	InputManager.on_key_board_and_mouse_input.connect(on_key_board_and_mouse_input)

	gear_list = PlayerSetup.inventory
	for i in gear_list.size()-1:
		var inv_item_button_scene = load(str(inv_item_button.resource_path))
		var inv_item_button_instance = inv_item_button_scene.instantiate()
		if item_list is ItemList:
			item_list.add_item(gear_list[i]._item_name, gear_list[i]._icon)
	

	await get_tree().create_timer(.3).timeout

	if !PlayerSetup.has_equipped_gear:
		for gear in PlayerSetup.equiped_gear:
			equip_gear(gear)
			PlayerSetup.has_equipped_gear = true

	no_results_warning.visible = false
	no_gear_warning.visible = false
	
func refresh_item_list():
	item_list.clear()

	#If player has no items, show warning and return
	if gear_list.size() == 0:
		no_gear_warning.visible = true
		return
	else:
		no_gear_warning.visible = false

	if filter_applied:
		for i in gear_list_filtered.size():
			if item_list is ItemList:
				item_list.add_item(gear_list_filtered[i]._item_name, gear_list_filtered[i]._icon)

	else:
		for i in gear_list.size():
			if item_list is ItemList:
				item_list.add_item(gear_list[i]._item_name, gear_list[i]._icon)

	#if item list is empty, show no results warning
	if item_list.item_count == 0:
		no_results_warning.visible = true
	else:
		no_results_warning.visible = false

func update_ui():
	gear_list = PlayerSetup.inventory
	refresh_item_list()
	if selected_item < 0:
		selected_item_options.disable_all_buttons()
	else:
		selected_item_options.enable_all_buttons()

func on_equip_button_pressed():
	equip_gear(gear_list[selected_item])

func equip_gear(gear: GearResource):
	#Equip selected item. Get already equiped item
	var return_gear: GearResource = equiped_gear_menu.equip_gear(gear) 
	
	#Remove existing mods if any
	if return_gear != null:
		for mod in return_gear.mod_list: #Go through each mod in returned gear
			if mod is GearModifier:
				#Check mod type and remove from corrisponding pool
				if mod.mod_type == GearModifier.GearModType.APPLY_NOW: 
					mod.upgrade_resource.upgrade.remove_upgrade(stat_container, mod.slot_source)
	
	upgrade_menu.remove_upgrades_by_source(gear._gear_type)
		
	#Apply mods from selected item
	for mod in gear.mod_list:
		if mod is GearModifier:
			mod.slot_source = gear._gear_type
			mod.upgrade_resource.source_type = gear._gear_type
			mod.upgrade_resource.upgrade.source_type = gear._gear_type
			if mod.mod_type == GearModifier.GearModType.APPLY_NOW:
				mod.upgrade_resource.upgrade.apply_upgrade_main_menu(stat_container, gear._gear_type)
			else: if mod.mod_type == GearModifier.GearModType.ADD_TO_COMBAT_POOL:
				mod.upgrade_resource.forced_upgrade = mod.forced_upgrade
				upgrade_menu.selected_upgrades.append(mod.upgrade_resource)
				
	if return_gear != null: #Add gear back to inventory
		add_item(return_gear)
		selected_info_box.on_item_select(equiped_gear_menu.get_gear_in_slot(return_gear._gear_type))
	if selected_item >= 0:
		remove_selected_item() #Remove selected item from inventory
	selected_item = -1
	selected_item_options.equip_button.disabled = true
	selected_item_options.delete_button.disabled = true
	is_equiped_item_selected = true
	
func add_item(gear: GearResource):
	gear_list.append(gear)
	item_list.add_item(gear._item_name, gear._icon)

func remove_selected_item():
	gear_list.erase(gear_list[selected_item])
	item_list.remove_item(selected_item)
	selected_item = -1
	update_ui()

func filter_by_type(gear_type: GearResource.GearType):
	selected_item = -1
	
	gear_list_filtered.clear()
	for gear in gear_list:
		if gear._gear_type == gear_type:
			gear_list_filtered.append(gear)
	filter_applied = true
	
	refresh_item_list()

func remove_filters():
	gear_list_filtered = gear_list.duplicate()
	filter_applied = false
	refresh_item_list()
	
func _on_item_list_item_selected(index):
	if filter_applied:
		selected_info_box.on_item_select(gear_list_filtered[index])
	else:
		selected_info_box.on_item_select(gear_list[index])
		
	selected_item = index
	selected_item_options.enable_all_buttons()
	is_equiped_item_selected = false


func _on_equiped_gear_menu_on_equiped_gear_selected():
	is_equiped_item_selected = true

func _on_craft_pressed():
	pass
	#if is_equiped_item_selected == false:
		#Open craft menu using selected item index from item list
	#else
		#open craft menu with the item in selected slot.

func on_key_board_and_mouse_input():
	item_list.focus_mode = Control.FOCUS_NONE

func on_controller_input():
	item_list.focus_mode = Control.FOCUS_ALL