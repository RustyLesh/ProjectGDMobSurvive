extends Control
class_name UpgradeOption
#Holds information of rolled upgrade, used to select upgrade in upgrade menu

@onready var button: Button = $Button
@onready var info_panel: UpgradeDescriptionPanel = $"Info Panel"

@export var upgrade : UpgradeResource
var _option_no: int

signal on_option_selected(option_no: int)

func init_button(option_no, upgrade_resource : UpgradeResource):
	_option_no = option_no
	upgrade = upgrade_resource
	info_panel.update_ui(upgrade)
	
func _on_button_pressed():
	on_option_selected.emit(_option_no)

func disable_button():
	button.disabled = true

func enable_button():
	button.disabled = false
