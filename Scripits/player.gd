extends Entity
class_name Player
@onready var xp_manager = get_parent().get_node("XP Manager")

func _on_health_died():
	get_tree().reload_current_scene()
	
func xp_pickup(value : float):
	if xp_manager is XPManager:
		xp_manager.xp_gained(value)
