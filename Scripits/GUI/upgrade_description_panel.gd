extends Panel
class_name UpgradeDescriptionPanel
#Shows info for selected upgrade

@onready var title : Label = $Title
@onready var description : Label = $Description
@onready var description_Auto_gen : Label = $Stats
@onready var uses_counter: Label = $"Uses Counter"
@onready var icon: TextureRect = $Icon

func update_ui(upgrade_resource : UpgradeResource):
	title.text = upgrade_resource._name
	icon.texture = upgrade_resource._icon
	description.text = upgrade_resource._description
	description_Auto_gen.text = upgrade_resource.upgrade.get_upgrade_string()
	uses_counter.text = str(upgrade_resource.current_uses, "/", upgrade_resource._max_uses)

#Clears text fields
func clear_info():
	title.text = ""
	description.text = ""
	uses_counter.text = ""
	description_Auto_gen.text = ""
