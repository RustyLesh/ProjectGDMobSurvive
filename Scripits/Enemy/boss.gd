extends EnemyNode
class_name Boss
#Base for boss classes

signal on_boss_death()

func _init():
	entity_type = EntityType.BOSS
	print("Boss Init")

func _on_health_died():
	on_boss_death.emit()
	super()
