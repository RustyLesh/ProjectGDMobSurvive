extends Node
class_name Entity
#Base for any scene that can take damage

enum EntityType
{
	GRUNT,
	BOSS,
	PLAYER,
}

@onready var health = $Health

@export var entity_type: EntityType

var is_dead: bool = false

func take_damage(damage):
	if health is Health:
		#Damage logic here
		health.take_damage(damage)
