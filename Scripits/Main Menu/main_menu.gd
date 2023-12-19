extends Control
class_name MainMenu
#Game main menu state machine
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

func _ready():
	weapon_select_menu.visible = false
	combat_menu.visible = false
	gear_menu.visible = false
	equipment_menu.visible = false
	character_menu.visible = false
	ability_menu.visible = false
	options_menu.visible = false
	
	change_menu(starting_menu)
	
func _on_button_pressed():
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
			
	current_menu = change_to

	match current_menu:
		MenuType.WEAPON_SELECT:
			weapon_select_menu.visible = true
			equipment_menu.visible = true
					
		MenuType.COMBAT:
			combat_menu.visible = true
			
		MenuType.GEAR:
			gear_menu.visible = true
			equipment_menu.visible = true
						
		MenuType.CHARACTER:
			character_menu.update_ui()
			character_menu.visible = true
			equipment_menu.visible = true
			
		MenuType.ABILITIES:
			ability_menu.visible = true
			
		MenuType.OPTIONS:
			options_menu.visible = true
			options_menu.update_ui()
