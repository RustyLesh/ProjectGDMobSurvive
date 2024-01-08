extends Control
class_name GearMenu

@onready var item_list: ItemList = $"ScrollContainer/Item List"
@onready var selected_info_box: SelectedItemInfo = $"Item Info"
@onready var equiped_gear_menu: EquipedGearMenu = $"../Equiped Gear Menu"
@onready var stat_container: MainMenuStatContainer = $"../Stat Container"
@onready var selected_item_options: HBoxContainer = $"Selected Item Options"

var inv_item_button: Resource = preload("res://Objects/Main Menu/inventory_item.tscn")

var gear_list_filtered: Array[GearResource]
var gear_list: Array[GearResource]

@export var selected_item: int
@export var is_equiped_item_selected: bool

func _ready():
	gear_list = PlayerSetup.inventory
	for i in gear_list.size()-1:
		var inv_item_button_scene = load(str(inv_item_button.resource_path))
		var inv_item_button_instance = inv_item_button_scene.instantiate()
		if item_list is ItemList:
			item_list.add_item(gear_list[i]._item_name, gear_list[i]._icon)

func refresh_item_list():
	item_list.clear()
	if !gear_list_filtered.is_empty():
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

func equip_gear():
	#Equip selected item. Get already equiped item
	var return_gear: GearResource = equiped_gear_menu.equip_gear(gear_list[selected_item]) 
	
	#Remove existing mods if any
	if return_gear != null:
		for mod in return_gear.mod_list: #Go through each mod in returned gear
			if mod is GearModifier:
				#Check mod type and remove from corrisponding pool
				if mod.mod_type == GearModifier.GearModType.APPLY_NOW: 
					mod.upgrade_resource.upgrade.remove_upgrade(stat_container)
		PlayerSetup.remove_upgrades_by_source(return_gear._gear_type)
	
	#Apply mods from selected item
	for mod in gear_list[selected_item].mod_list:
		if mod is GearModifier:
			if mod.mod_type == GearModifier.GearModType.APPLY_NOW:
				mod.upgrade_resource.upgrade.apply_upgrade_main_menu(stat_container)
			else: if mod.mod_type == GearModifier.GearModType.ADD_TO_COMBAT_POOL:
				mod.slot_source = gear_list[selected_item]._gear_type
				mod.upgrade_resource.upgrade.source_type = gear_list[selected_item]._gear_type
				PlayerSetup.upgrade_pool.append(mod.upgrade_resource)
				
	if return_gear != null: #Add gear back to inventory
		add_item(return_gear)
		selected_info_box.on_item_select(equiped_gear_menu.get_gear_in_slot(return_gear._gear_type))
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
	
	refresh_item_list()

func remove_filters():
	gear_list_filtered = gear_list.duplicate()
	refresh_item_list()
	
func _on_item_list_item_selected(index):
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
