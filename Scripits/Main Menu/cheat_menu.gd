extends Control

#Give Gear
@onready var gear_menu:GearMenu = %"Gear Menu"
@export var gear_to_give: Array[GearResource]
@onready var save_data: TextEdit = $"Save Data"
@onready var load_data: TextEdit = $"Load Data"

func _ready():
	PlayerSetup.on_saving.connect(_on_saving)
	PlayerSetup.on_loading.connect(_on_loading)

func _on_give_gear_pressed():
	for gear in gear_to_give:
		gear_menu.add_item(gear)

func _on_load_pressed():
	SaveManager.load_game()

func _on_save_pressed():
	SaveManager.save_game()

func _on_saving(save_str: String):
	save_data.text = save_str

func _on_loading(load_str: String):
	load_data.text = load_str