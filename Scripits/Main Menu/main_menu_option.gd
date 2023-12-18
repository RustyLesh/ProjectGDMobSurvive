extends Button
class_name MainMenuOption
#Button used on main menu to select menu scenes

@onready var main_menu: MainMenu = $"../../../../.."
@export var menu_option_type: MainMenu.MenuType

func _ready():
	pressed.connect(on_button_pressed)

func on_button_pressed():
	main_menu.change_menu(menu_option_type)
