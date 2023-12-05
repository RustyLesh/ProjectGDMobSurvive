extends Panel
class_name SelectedItemInfo

@onready var name_label: Label = $Name
@onready var description_label: Label = $Description
@onready var mod_list: RichTextLabel = $"Mod list"

func on_item_select(gear: Gear):
	name_label.text = gear.name
	description_label.text = gear.description

	for mod in gear.mod_list:
		mod_list.clear() #Clear mod text
		mod_list.append_text(str(mod.upgrade.upgrade.get_upgrade_string()) + "\n")
