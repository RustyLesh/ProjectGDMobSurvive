extends Control
class_name UpgradeOption
#Holds information of rolled upgrade, used to select upgrade in upgrade menu

@export var upgrade : UpgradeResource
var _option_no: int
@onready var button: Button = $Button
signal on_option_selected(option_no: int)

func init_button(option_no, upgrade_resource : UpgradeResource):
	_option_no = option_no
	upgrade = upgrade_resource
	button.icon = upgrade_resource.icon
	
func _on_button_pressed():
	on_option_selected.emit(_option_no)
