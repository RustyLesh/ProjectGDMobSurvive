extends Node
class_name Health

signal on_damaged(value)
signal max_health_changed(max_health)
signal current_health_changed(max_health)
signal died()

@export var max_health = 1
@export var current_health = max_health
var is_alive = true

func init_health(maxHealth : int):
	set_max_health((maxHealth))
	current_health = maxHealth

func take_damage(damage):
	if damage > 0:
		current_health -= damage
		if current_health <= 0:
			is_alive = false
			died.emit()
		current_health_changed.emit(current_health)

func heal(value):
	if value > 0:
		current_health = clamp(current_health + value, 0, max_health)
		current_health_changed.emit(current_health)

func set_max_health(value : int):
	if max_health != value:
		max_health = value
		if current_health > max_health:
			current_health = max_health
			print("health changed ", max_health)
		max_health_changed.emit(max_health)
