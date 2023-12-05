extends Control

@onready var item_list: ItemList = $"MarginContainer/Item List"
@onready var selected_info_box: SelectedItemInfo = $"Item Info"
@onready var equiped_gear_menu: EquipedGearMenu = $"../Equiped Gear Menu"
@onready var stat_container: MainMenuStatContainer = $"../Stat Container"

var inv_item_button: Resource = preload("res://Objects/Main Menu/inventory_item.tscn")

@export var gear_list: Array[Gear]
@export var selected_item: int
func _ready():
	for i in gear_list.size():
		var inv_item_button_scene = load(str(inv_item_button.resource_path))
		var inv_item_button_instance = inv_item_button_scene.instantiate()
		if item_list is ItemList:
			item_list.add_item(gear_list[i].name, gear_list[i].icon)

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	print("Selected item index: ", index)
	selected_info_box.	on_item_select(gear_list[index])
	selected_item = index

func equip_gear():
	#Equip selected item. Get already equiped item
	var return_gear = equiped_gear_menu.equip_gear(gear_list[selected_item]) 
	
	#Remove existing mods if any
	if return_gear != null:
		for mod in return_gear.mod_list:
			if mod is GearModifier:
				mod.upgrade.upgrade.remove_upgrade(stat_container)
	
	#Apply mods from selected item
	for mod in gear_list[selected_item].mod_list:
		if mod is GearModifier:
			mod.upgrade.upgrade.apply_upgrade_main_menu(stat_container)
	
	if return_gear != null: #Add gear back to inventory
		add_item(return_gear)
	remove_selected_item() #Remove selected item from inventory
	
	selected_item = 0

func add_item(gear: Gear):
	gear_list.append(gear)
	item_list.add_item(gear.name, gear.icon)

func remove_selected_item():
	gear_list.erase(gear_list[selected_item])
	item_list.remove_item(selected_item)

