extends Control

@onready var start_button: Button = $Start
@onready var button_container = $HBoxContainer
@onready var buttons = button_container.get_children()
@onready var gear_warning: Label = $"Not Enough Upgrades Warning"
@onready var can_start: bool = false

func _ready():
	start_button.disabled = true

func on_mission_select():
	can_start = true
	update_ui()

func update_ui():
	#Update stage select buttons
	for button in buttons:
		if button.difficulty - 1 > PlayerStats.highest_stage_completed:
			button.disabled = true
		else:
			button.disabled = false

	#Gear check
	if PlayerSetup.selected_upgrades.size() < 6:
		can_start = false
		gear_warning.visible = true
	else:
		gear_warning.visible = false

	if can_start:
		start_button.disabled = false
	else:
		start_button.disabled = true
