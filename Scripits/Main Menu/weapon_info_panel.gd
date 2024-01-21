extends Node
class_name WeaponInfoPanel

@onready var upgrade_info_panel: Panel = $"Upgrade info"
@onready var stat_list: ItemList= $"Lists/Upgrade List Scroll/Mods List"
@onready var upgrade_list: ItemList= $"Lists/Mod List Scroll/Upgrade List"
@onready var equip_button: Button = $"Weapon Actions/Equip Button"
@onready var skill_tree_button: Button = $"Weapon Actions/Skill Tree Button"
@onready var confirmation_panel: Panel = $"Confirmation Panel"

var weapon_resource: WeaponResource

var confirmation_check: bool
signal on_equip(weapon_resource: WeaponResource)

func _ready():
	upgrade_info_panel.visible = false
	confirmation_panel.visible = false

func init_info_panel(_weapon_resource: WeaponResource):
	upgrade_list.clear()
	weapon_resource = _weapon_resource
	for mod in weapon_resource.upgrades:
		upgrade_list.add_item(mod._name, mod._icon)

func set_data(weapon_resource: WeaponResource):
	pass

func _on_equip_button_pressed():
	confirmation_panel.visible = true

func on_upgrade_list_select(_index):
	upgrade_info_panel.visible = true

func on_close_upgrade_info_panel_pressed():
	upgrade_info_panel.visible = false

func equip_confirmed():
	on_equip.emit(weapon_resource)
	confirmation_panel.visible = false

func equip_decline():
	confirmation_panel.visible = false

func on_skill_tree_pressed():
	pass
