extends HBoxContainer
class_name SelecteditemOptions

@onready var equip_button: Button = $Equip
@onready var craft_button: Button = $Craft
@onready var delete_button: Button = $Delete

func _ready():
	disable_all_buttons()

func disable_all_buttons():
	equip_button.disabled = true
	craft_button.disabled = true
	delete_button.disabled = true

func enable_all_buttons():
	equip_button.disabled = false
	craft_button.disabled = false
	delete_button.disabled = false
