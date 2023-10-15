extends Node

const Health = preload("health.gd")
@onready var health = $Health

func take_damage(damage):
	if health is Health:
		#Damage logic here
		health.take_damage(damage)
