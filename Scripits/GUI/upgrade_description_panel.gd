extends Panel
class_name UpgradeDescriptionPanel
#Shows info for selected upgrade

@onready var title : Label = $Title
@onready var description : Label = $Description
@onready var uses_counter: Label = $"Uses Counter"

func update_ui(upgrade_resource : UpgradeResource):
	title.text = upgrade_resource._name
	description.text = upgrade_resource._description
	uses_counter.text = str(upgrade_resource.current_uses, "/", upgrade_resource._max_uses)

#Clears text fields
func clear_info():
	title.text = ""
	description.text = ""
	uses_counter.text = ""
