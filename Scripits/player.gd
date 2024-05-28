extends Entity
class_name Player
#Stores references for objects in player scene

@onready var xp_manager = get_parent().get_node("XP Manager")
@onready var weapon_manager: WeaponManager = $"Weapon Manager"
@onready var combat_stat_container: StatContainer = $"Combat Stat Container"
@onready var player_body: PlayerController = $Body
@onready var on_kill_effect_manager: OnKillEffectsManager = %"On Kill Effects Manager"
@export var i_frame_colour:= Color.RED
@export var i_frame_duration : float  = 0.5#seconds
@export var weapon_resource: WeaponResource

var weapon_inst: Weapon
var is_invulnerable: bool = false

signal on_player_death()

func _ready():
	combat_stat_container.combat_init()
	await get_tree().create_timer(.5).timeout
	init_entity()

	if PlayerSetup.weapon_resource != null:
		weapon_resource = PlayerSetup.weapon_resource.duplicate()
		if weapon_manager is WeaponManager:
			weapon_inst = weapon_resource.weapon.instantiate()
			weapon_manager.add_child(weapon_inst)
			weapon_inst.init_weapon(combat_stat_container.base_stats)

func _on_health_died():
	print("Player death emitted")
	on_player_death.emit()
	
func xp_pickup(value : float):
	if xp_manager is XPManager:
		xp_manager.xp_gained(value)

func take_damage(damage):
	if !is_invulnerable:
		if health is Health:
			#Damage logic here
			print("D2amage: ", damage)
			health.take_damage(damage)
			i_frame_timer()

func i_frame_timer():
	is_invulnerable = true
	# TODO change colour when invul
	sprite.material.set_shader_parameter("flash_opacity", 1.0)
	await get_tree().create_timer(i_frame_duration).timeout
	is_invulnerable = false
	sprite.material.set_shader_parameter("flash_opacity", 0.0)
