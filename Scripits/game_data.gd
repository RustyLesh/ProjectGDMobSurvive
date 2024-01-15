extends Node

func _ready():
	get_tree().set_auto_accept_quit(false)

func go_to_main_menu():
	PlayerSetup.end_of_stage()
	PlayerStats.end_of_stage()
	SaveManager.save_game()
	get_tree().change_scene_to_file("res://Objects/Main Menu/main_menu.tscn")

func quit_game():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		await get_tree().create_timer(0.1).timeout
		if get_tree().current_scene.name == "Main Menu":
			quit_process()
		else:
			print("Progress is not saved")
			#Confirm prompt uset for quit, tell user progress is not saved
		get_tree().quit()
		
func quit_process():
	SaveManager.save_game()


	
