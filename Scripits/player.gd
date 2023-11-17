extends Entity
class_name Player
@onready var xp_manager = get_parent().get_node("XP Manager")
@onready var weapon_manager = $"Weapon Manager"

@export var i_frame_colour:= Color.RED
@export var i_frame_duration : float  = 0.2#seconds
@export var weapon: WeaponResource
var is_invulnerable: bool = false

signal on_player_death()

func _ready():
	weapon = PlayerSetup.weapon
	print(weapon)
	if weapon_manager is WeaponManager:
		var weapon_inst = weapon.weapon.instantiate()
		weapon_manager.add_child(weapon_inst)
		weapon_inst.init_weapon()
	
func _on_health_died():
	on_player_death.emit()
	get_tree().reload_current_scene() #Reset the game
	
func xp_pickup(value : float):
	if xp_manager is XPManager:
		xp_manager.xp_gained(value)

func take_damage(damage):
	if !is_invulnerable:
		if health is Health:
			#Damage logic here
			health.take_damage(damage)
			i_frame_timer()

func i_frame_timer():
	is_invulnerable = true
	# TODO change colour when invul
	sprite.modulate = i_frame_colour
	await get_tree().create_timer(i_frame_duration).timeout
	is_invulnerable = false
	sprite.modulate = Color.WHITE
