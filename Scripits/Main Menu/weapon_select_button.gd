extends Button

signal on_weapon_select(weapon: Weapon)

@export var weapon: WeaponResource

func _on_pressed():
	on_weapon_select.emit(weapon)
