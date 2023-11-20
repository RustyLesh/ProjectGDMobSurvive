extends Control

enum MenuType
{
	SPLASH,
	START,
	WEAPON_SELECT,
	COMBAT_MENU,
}

@onready var weapon_select_menu = $"Weapon Select Menu"

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Objects/combat_level.tscn")
