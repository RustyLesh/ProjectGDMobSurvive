extends Node
#Main enemy functions

func _on_health_died():
	queue_free()
