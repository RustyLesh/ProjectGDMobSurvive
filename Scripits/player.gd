extends "entity.gd"

func _on_health_died():
	get_tree().reload_current_scene()
	
