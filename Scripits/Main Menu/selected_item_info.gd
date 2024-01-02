extends Panel
class_name SelectedItemInfo

@onready var name_label: Label = $Name
@onready var description_label: Label = $Description
@onready var mod_list: RichTextLabel = $"Mod list"

func on_item_select(gear: GearResource):
	if gear != null:
		name_label.text = gear._item_name
		description_label.text = gear._description

		mod_list.clear() #Clear mod text
		#Add mod list text
		for mod in gear.mod_list:
			if mod.mod_type == GearModifier.GearModType.APPLY_NOW:
				mod_list.append_text(str(mod.upgrade_resource.upgrade.get_upgrade_string()) + "\n")
			else: if mod.mod_type == GearModifier.GearModType.ADD_TO_COMBAT_POOL:\
				mod_list.append_text(str("[UPGRADE] " + mod.upgrade_resource.upgrade.get_upgrade_string()) + "\n")

