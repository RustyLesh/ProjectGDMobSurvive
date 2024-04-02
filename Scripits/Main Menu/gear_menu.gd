extends Control
class_name GearMenu

@onready var upgrade_menu: UpgradeManageMenu = $"../Upgrade Menu"
@onready var item_list: ItemList = $"ScrollContainer/Item List"
@onready var selected_info_box: SelectedItemInfo = $"Item Info"
@onready var equiped_gear_menu: EquipedGearMenu = $"../Equiped Gear Menu"
@onready var stat_container: MainMenuStatContainer = $"../Stat Container"
@onready var selected_item_options: HBoxContainer = $"Selected Item Options"

var inv_item_button: Resource = preload("res://Objects/Main Menu/inventory_item.tscn")

var gear_list_filtered: Array[GearResource]
var gear_list: Array[GearResource]
var filter_applied: bool

@export var selected_item: int = -1
@export var is_equiped_item_selected: bool

func _ready():
	gear_list = PlayerSetup.inventory
	for i in gear_list.size()-1:
		var inv_item_button_scene = load(str(inv_item_button.resource_path))
		var inv_item_button_instance = inv_item_button_scene.instantiate()
		if item_list is ItemList:
			item_list.add_item(gear_list[i]._item_name, gear_list[i]._icon)
	
	await get_tree().create_timer(.3).timeout
	print("equiping")
	for gear in PlayerSetup.equiped_gear:
		print("equiping part 2")
		equip_gear(gear)
	
func refresh_item_list():
	item_list.clear()
	if filter_applied:
		for i in gear_list_filtered.size()-1:
			if item_list is ItemList:
				item_list.add_item(gear_list_filtered[i]._item_name, gear_list_filtered[i]._icon)
	else:
		for i in gear_list.size()-1:
			if item_list is ItemList:
				item_list.add_item(gear_list[i]._item_name, gear_list[i]._icon)

func update_ui():
	gear_list = PlayerSetup.inventory
	refresh_item_list()

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

func filter_by_type(gear_type: GearResource.GearType):
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
