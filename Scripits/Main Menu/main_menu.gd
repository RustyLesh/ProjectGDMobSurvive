extends Control
class_name MainMenu
enum MenuType
{
	SPLASH,
	START,
	WEAPON_SELECT,
	COMBAT,
	OPTIONS,
	GEAR,
	CHARACTER,
}

#Menu to start on launch
@export var starting_menu: MenuType 
var current_menu: MenuType

@onready var weapon_select_menu = $"Weapon Select Menu"
@onready var combat_menu = $"Combat Prep Menu"
@onready var gear_menu = $"Gear Menu"

func _ready():
	weapon_select_menu.visible = false
	combat_menu.visible = false
	gear_menu.visible = false
	
	change_menu(starting_menu)
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Objects/combat_level.tscn")

func change_menu(change_to: MenuType):
	match current_menu:
		MenuType.WEAPON_SELECT:
			weapon_select_menu.visible = false
		
		MenuType.COMBAT:
			combat_menu.visible = false
	
		MenuType.GEAR:
			gear_menu.visible = false
			
	current_menu = change_to

	match current_menu:
		MenuType.WEAPON_SELECT:
			weapon_select_menu.visible = true
		
		MenuType.COMBAT:
			combat_menu.visible = true
			
		MenuType.GEAR:
			gear_menu.visible = true
