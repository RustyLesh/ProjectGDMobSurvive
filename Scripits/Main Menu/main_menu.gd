##Game main menu state machine
class_name MainMenu extends Control
enum MenuType
{
	SPLASH,
	START,
	WEAPON_SELECT,
	COMBAT,
	OPTIONS,
	GEAR,
	CHARACTER,
	ABILITIES,
	UPGRADES,
}

signal on_start_combat()

#Menu to start on launch
@export var starting_menu: MenuType 
var current_menu: MenuType

#Menus
@onready var equipment_menu = $"Equiped Gear Menu"
@onready var weapon_select_menu = $"Weapon Select Menu"
@onready var ability_menu = $"Ability Menu"
@onready var gear_menu = $"Gear Menu"
@onready var character_menu: CharacterMenu = $"Character Menu"
@onready var combat_menu = $"Combat Prep Menu"
@onready var options_menu = $"Options Menu"
@onready var upgrade_menu = $"Upgrade Menu"
@onready var stat_container = $"Stat Container"
@onready var weapon_warning_dialogue: Control = $"Weapon Warning Dialogue"
@onready var mode_menu_options_container = $"Mode Menu/Menu Options/MarginContainer/HBoxContainer"

func _ready():
	weapon_select_menu.visible = false
	combat_menu.visible = false
	gear_menu.visible = false
	equipment_menu.visible = false
	character_menu.visible = false
	ability_menu.visible = false
	options_menu.visible = false
	upgrade_menu.visible = false
	
	weapon_warning_dialogue.visible = false
	change_menu(starting_menu)
	get_tree().paused = false

	stat_container.main_menu_init()
	
	mode_menu_options_container.get_child(0).grab_focus()

	InputManager.on_controller_input.connect(on_controller_input)
	InputManager.on_key_board_and_mouse_input.connect(on_keybaord_and_mouse_input)

func on_quit_button_pressed():
	GameData.quit_game()
	
#Combat start
func _on_button_pressed():
	if PlayerSetup.weapon == null: #Check if weapon equiped
		weapon_warning_dialogue.visible = true
	else:
		on_start_combat.emit()
		SaveManager.save_game()
		get_tree().change_scene_to_file("res://Objects/combat_level.tscn")

func change_menu(change_to: MenuType):
	match current_menu:
		MenuType.WEAPON_SELECT:
			weapon_select_menu.visible = false
			equipment_menu.visible = false
			
		MenuType.COMBAT:
			combat_menu.visible = false
			
		MenuType.GEAR:
			gear_menu.visible = false
			equipment_menu.visible = false
			
		MenuType.CHARACTER:
			character_menu.visible = false
			equipment_menu.visible = false
		
		MenuType.ABILITIES:
			ability_menu.visible = false
		
		MenuType.OPTIONS:
			options_menu.visible = false

		MenuType.UPGRADES:
			upgrade_menu.visible = false		

			
	current_menu = change_to

	match current_menu:
		MenuType.WEAPON_SELECT:
			weapon_select_menu.visible = true
			equipment_menu.visible = true
					
		MenuType.COMBAT:
			combat_menu.visible = true
			combat_menu.update_ui()
			
		MenuType.GEAR:
			gear_menu.visible = true
			equipment_menu.visible = true
			gear_menu.update_ui()
						
		MenuType.CHARACTER:
			character_menu.update_ui()
			character_menu.visible = true
			equipment_menu.visible = true
			
		MenuType.ABILITIES:
			ability_menu.visible = true
			
		MenuType.OPTIONS:
			options_menu.visible = true
			#options_menu.update_ui()

		MenuType.UPGRADES:
			upgrade_menu.visible = true
			upgrade_menu.update_ui()

func on_controller_input():
	#if !InputManager.controller_was_used_last:
	if get_viewport().gui_get_focus_owner() == null:
		print("grabbed")
		mode_menu_options_container.get_child(0).grab_focus()

func on_keybaord_and_mouse_input():
	if InputManager.controller_was_used_last:
		print("release")
		get_viewport().gui_release_focus()