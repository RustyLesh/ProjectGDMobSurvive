extends CanvasLayer
class_name MenuManager
#Manages menus in combat

@onready var upgrade_menu: Control = $"Uprade Menu"
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	upgrade_menu.visible = false
	
func _input(event):
	if event.is_action_pressed("open_upgrade_menu"):
		toggle_upgrade_menu()

func _on_button_pressed():
	toggle_upgrade_menu()

func toggle_upgrade_menu():
	upgrade_menu.visible = !upgrade_menu.visible
	get_tree().paused = upgrade_menu.visible
