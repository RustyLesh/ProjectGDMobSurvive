extends Node

signal health_changed(health)
signal died()

@export var max_health = 1
@export var current_health = max_health
var is_alive = true

func take_damage(damage):
	if damage > 0:
		current_health -= damage
		if current_health <= 0:
			is_alive = false
			died.emit()

func heal(value):
	if value > 0:
		current_health = clamp(current_health + value, 0, max_health)

