extends Node
class_name Entity

enum EntityType{
	GRUNT,
	BOSS
}

@onready var health = $Health
@export var entity_type: EntityType

func take_damage(damage):
	if health is Health:
		#Damage logic here
		health.take_damage(damage)
