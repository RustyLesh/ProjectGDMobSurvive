extends Panel

@onready var title = $Title
@onready var description = $Description
@onready var stats = $Stats

func update_ui(upgrade_resource: UpgradeResource):
	title.text = upgrade_resource._name
	description.text = upgrade_resource._description
	stats.text = upgrade_resource.upgrade.get_upgrade_string()

