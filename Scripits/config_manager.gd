extends Node

#Player Options

#GUI
var show_touch_joy_stick: bool = true

var file_path: String = "user://settings.config"
var config = ConfigFile.new()

var err = config.load(file_path)

func _ready():
    if err != OK:
        print("opening config file failed" +str(err))
        return
    
    for section in config.get_sections():
        show_touch_joy_stick = config.get_value(section, "show_touch_joy_stick")

func save_config():
    config.set_value("Settings", "show_touch_joy_stick", show_touch_joy_stick)
    config.save(file_path)

func _notification(what):
    if what == NOTIFICATION_WM_CLOSE_REQUEST: 
        save_config()