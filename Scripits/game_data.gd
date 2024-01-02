extends Node

var has_first_load: bool = false

func go_to_main_menu():
	PlayerSetup.inventory.append_array(PlayerSetup.gear_drops)
	PlayerSetup.gear_drops.clear()
	SaveManager.save_game()
	get_tree().change_scene_to_file("res://Objects/Main Menu/main_menu.tscn")

	
