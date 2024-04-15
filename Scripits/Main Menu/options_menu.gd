extends Control
class_name OptionsMenu

@onready var show_touch_joy_stick: Button = $"VBoxContainer/Show Touch Sticks/Show Touch Sticks Button"
@onready var cheat_menu = $"Cheat Menu"

func _ready():
	show_touch_joy_stick.button_pressed = ConfigManager.show_touch_joy_stick
	
	cheat_menu.visible = DevTools.cheat_menu_visible

func _on_button_toggled(button_pressed:bool):
	ConfigManager.show_touch_joy_stick = button_pressed
	
