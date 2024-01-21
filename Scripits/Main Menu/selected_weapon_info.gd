extends Panel
class_name WeaponSelectInfo
#Menu panel to show information on selected weapon in weapon menu

@onready var weapon_name: Label = $Name
@onready var description: Label = $Description
@onready var icon: TextureRect = $Icon

func on_weapon_select(weapon, _index):
	if weapon is WeaponResource:
		icon.texture = weapon.icon
		weapon_name.text = weapon.weapon_name
		description.text = weapon.description

