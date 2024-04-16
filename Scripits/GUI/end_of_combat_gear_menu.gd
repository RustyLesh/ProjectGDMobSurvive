extends Control
class_name EndOfCombatGearMenu

@onready var item_list: ItemList = $"ScrollContainer/Item List"
@onready var selected_info_box: SelectedItemInfo = $"Item Info"
@onready var selected_item_options: HBoxContainer = $"Selected Item Options"
@onready var no_gear_warning: Label = $"No Gear Warning"
var inv_item_button: Resource = preload("res://Objects/Main Menu/inventory_item.tscn")

var gear_list: Array[GearResource]

@export var selected_item: int = -1
@export var is_equiped_item_selected: bool

func _ready():
	InputManager.on_controller_input.connect(on_controller_input)
	InputManager.on_key_board_and_mouse_input.connect(on_key_board_and_mouse_input)

	gear_list = PlayerSetup.gear_drops

func refresh_item_list():
	item_list.clear()

	#If player has no items, show warning and return
	if gear_list.size() == 0:
		no_gear_warning.visible = true
		return
	else:
		no_gear_warning.visible = false

	for i in gear_list.size():
		if item_list is ItemList:
			item_list.add_item(gear_list[i]._item_name, gear_list[i]._icon)

func update_ui():
	gear_list = PlayerSetup.inventory
	refresh_item_list()
	if selected_item < 0:
		selected_item_options.disable_all_buttons()
	else:
		selected_item_options.enable_all_buttons()
	
func add_item(gear: GearResource):
	gear_list.append(gear)
	item_list.add_item(gear._item_name, gear._icon)

func remove_selected_item():
	gear_list.erase(gear_list[selected_item])
	item_list.remove_item(selected_item)
	selected_item = -1
	update_ui()
	
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

func on_key_board_and_mouse_input():
	item_list.focus_mode = Control.FOCUS_NONE

func on_controller_input():
	item_list.focus_mode = Control.FOCUS_ALL