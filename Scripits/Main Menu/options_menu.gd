extends Control
class_name OptionsMenu

@onready var show_touch_joy_stick: Button = $"VBoxContainer/Show Touch Sticks/Show Touch Sticks Button"
@onready var show_touch_divider: Button = $"VBoxContainer/Show Touch Divider/Show Touch Divider Button"
@onready var touch_controll_opacity: Slider = $"VBoxContainer/Touch Control Opacity/HSlider"
@onready var cheat_menu = $"Cheat Menu"


func _ready():
	show_touch_joy_stick.button_pressed = ConfigManager.show_touch_joy_stick
	show_touch_divider.button_pressed = ConfigManager.show_touch_divider
	touch_controll_opacity.value = ConfigManager.trouch_controls_opacity
	
	cheat_menu.visible = DevTools.cheat_menu_visible
	


func _on_show_touch_divider_button_toggled(button_pressed:bool):
	ConfigManager.show_touch_divider = button_pressed

func _on_show_touch_sticks_button_toggled(button_pressed:bool):
	ConfigManager.show_touch_joy_stick = button_pressed

func _on_touch_controll_opacity_drag_ended(value: float):
	ConfigManager.trouch_controls_opacity = value

