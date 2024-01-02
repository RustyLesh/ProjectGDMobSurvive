extends Control
class_name OptionsMenu

#Save Load
@onready var save_button: Button = $Save
@onready var load_button: Button = $Load

#TEST DATA save load testing
@onready var test_data_label: Label = $Label

func _ready():
	update_ui()

func update_ui():
	test_data_label.text = str("Weapon XP: ", PlayerStats.weapon_xp)
	
