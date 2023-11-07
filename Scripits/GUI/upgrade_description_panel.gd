extends Panel
class_name UpgradeDescriptionPanel

@onready var title : Label = $Title
@onready var description : Label = $Description
@onready var uses_counter: Label = $"Uses Counter"

func update_ui(upgrade_resource : UpgradeResource):
	title.text = upgrade_resource.name
	description.text = upgrade_resource.description
	uses_counter.text = str(upgrade_resource.current_uses, "/", upgrade_resource.max_uses)

func clear_info():
	title.text = ""
	description.text = ""
	uses_counter.text = ""
