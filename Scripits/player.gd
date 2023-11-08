extends Entity
class_name Player
@onready var xp_manager = get_parent().get_node("XP Manager")

@export var i_frame_duration : float  = 0.2#seconds
var is_invulnerable: bool = false

func _on_health_died():
	get_tree().reload_current_scene()
	
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
	sprite.modulate = Color.RED
	await get_tree().create_timer(i_frame_duration).timeout
	is_invulnerable = false
	sprite.modulate = Color.WHITE
