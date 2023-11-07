extends Enemy
class_name Boss

signal on_boss_death()

func _init():
	entity_type = EntityType.BOSS
	print("Boss Init")

func _on_health_died():
	on_boss_death.emit()
	super()
