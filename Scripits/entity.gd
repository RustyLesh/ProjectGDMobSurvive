extends Node
class_name Entity

@onready var health = $Health

func take_damage(damage):
	if health is Health:
		#Damage logic here
		health.take_damage(damage)
