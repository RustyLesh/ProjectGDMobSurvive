extends Control
class_name WeaponSelectInfo
#Menu panel to show information on selected weapon in weapon menu

@onready var weapon_name: Label = $Name
@onready var description: Label = $Description
@onready var icon: TextureRect = $Icon
@onready var gear_manage_menu: UpgradeManageMenu = $"../../Upgrade Menu"

func _on_weapon_select(weapon):
	if weapon is WeaponResource:
		icon.texture = weapon.icon
		weapon_name.text = weapon.weapon_name
		description.text = weapon.description
		PlayerSetup.weapon = weapon
		gear_manage_menu.remove_upgrade_by_slot_type(GearResource.GearType.WEAPON)
		for upgrade in weapon.upgrades:
			upgrade.source_type = GearResource.GearType.WEAPON
			upgrade.upgrade.source_type = GearResource.GearType.WEAPON
			gear_manage_menu.upgrade_pool.append(upgrade)


