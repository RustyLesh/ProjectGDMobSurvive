extends Node
## Player Options manager

#GUI
var show_touch_joy_stick: bool
var show_touch_divider: bool
var trouch_controls_opacity: float

var file_path: String = "user://settings.config"
var config = ConfigFile.new()

var err = config.load(file_path)

func _ready():
	load_config()

func save_config():
	config.set_value("Settings", "show_touch_joy_stick", show_touch_joy_stick)
	config.set_value("Settings", "show_touch_divider", show_touch_divider)
	config.set_value("Settings", "trouch_controls_opacity", trouch_controls_opacity)
	config.save(file_path)

func load_config():
	if err != OK:
		print("opening config file failed" +str(err))
		return
	
	for section in config.get_sections():
		show_touch_joy_stick = config.get_value(section, "show_touch_joy_stick", true)
		show_touch_divider = config.get_value(section, "show_touch_divider", true)
		trouch_controls_opacity = config.get_value(section, "trouch_controls_opacity", 50)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST: 
		save_config()
