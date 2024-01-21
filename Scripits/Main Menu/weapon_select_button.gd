extends Button
class_name WeaponSelectButton
#Holds a weapon and sends it to weapon select menu on clock

@onready var xp_bar: TextureProgressBar = $"XP Progress Bar"
@onready var xp_label: Label = $"XP Label"
@onready var lvl_label: Label = $"Level Label"

@export var weapon: WeaponResource

var index: int

signal on_weapon_select(weapon: Weapon, index)

func _ready():
	await get_tree().create_timer(0.5).timeout
	xp_bar.value = (weapon.get_current_xp() / weapon.get_xp_for_next_level()) * 100
	xp_label.text = str(weapon.get_current_xp()," / ", weapon.get_xp_for_next_level())
	lvl_label.text = str(weapon.level)
	
func _on_pressed():
	on_weapon_select.emit(weapon, index)
