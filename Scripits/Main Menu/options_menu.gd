extends Control
class_name OptionsMenu

#Save Load
@onready var save_manager: SaveManager = $"../Save Manager"
@onready var save_button: Button = $Save
@onready var load_button: Button = $Load

#TEST DATA save load testing
@onready var test_data_label: Label = $Label

func _ready():
	update_ui()

func update_ui():
	test_data_label.text = str("Weapon XP: ", PlayerStats.weapon_xp)
	
func _on_save_pressed():
	save_manager.save_game()
	update_ui()

func _on_load_pressed():
	save_manager.load_game()
