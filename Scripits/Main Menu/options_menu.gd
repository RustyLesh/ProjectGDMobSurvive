extends Control
class_name OptionsMenu

@onready var show_touch_joy_stick: Button = $"VBoxContainer/Show Touch Sticks/Show Touch Sticks Button"

func _ready():
	show_touch_joy_stick.button_pressed = ConfigManager.show_touch_joy_stick

func _on_button_toggled(button_pressed:bool):
	ConfigManager.show_touch_joy_stick = button_pressed
	
