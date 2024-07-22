extends Panel
class_name UpgradeDescriptionPanel
#Shows info for selected upgrade

@onready var title : Label = $Title
@onready var description : Label = $Description
@onready var description_Auto_gen : Label = $Stats
@onready var uses_counter: Label = $"Uses Counter"
@onready var icon: TextureRect = $Icon
@onready var added_upgrade_box: HBoxContainer = $"AddedUpgrades"
@onready var added_upgrade_icons = added_upgrade_box.get_children()

func update_ui(upgrade_resource : UpgradeResource):
	title.text = upgrade_resource._name
	icon.texture = upgrade_resource._icon
	description.text = upgrade_resource._description
	description_Auto_gen.text = ""
	for upgrade in upgrade_resource.upgrades:
		if upgrade == null:
			print("Null ugrade: ", upgrade_resource._name)
		print("Upgrade option name: ", upgrade_resource._name)
		description_Auto_gen.text += str(upgrade.get_upgrade_string(), "\n")
	uses_counter.text = str(upgrade_resource.current_uses, "/", upgrade_resource._max_uses)

	for icon in added_upgrade_box.get_children():
		if icon is TextureRect:
			icon.texture = null

	for i in upgrade_resource.added_upgrades.size():
		added_upgrade_icons[i].texture = upgrade_resource.added_upgrades[i]._icon

#Clears text fields
func clear_info():
	title.text = ""
	description.text = ""
	uses_counter.text = ""
	description_Auto_gen.text = ""
