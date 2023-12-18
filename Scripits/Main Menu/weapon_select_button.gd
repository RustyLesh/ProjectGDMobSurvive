extends Button
class_name WeaponSelectButton
#Holds a weapon and sends it to weapon select menu on clock

signal on_weapon_select(weapon: Weapon)
@export var weapon: WeaponResource

func _on_pressed():
	on_weapon_select.emit(weapon)
