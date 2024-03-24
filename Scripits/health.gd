extends Node
class_name Health
#Stores health and deals with taking damage for entities

signal on_damaged(value)
signal max_health_changed(max_health)
signal current_health_changed(current_health)
signal current_health_percent_changed(current_health_percent)
signal died()

@export var max_health = 100
@export var current_health: int
var is_alive = true

func init_health(maxHealth : int):
	set_max_health((maxHealth))
	current_health = maxHealth

func take_damage(damage):
	if (damage > 0):
		current_health -= damage
		#Dead check
		if current_health <= 0 && is_alive:
			is_alive = false
			died.emit()
		#Signal emitting
		current_health_changed.emit(current_health)
		var current_percent = ((current_health * 100 /max_health * 100) )
		current_health_percent_changed.emit(current_percent)

func heal(value):
	if value > 0:
		current_health = clamp(current_health + value, 1, max_health)
		current_health_changed.emit(current_health)
		current_health_percent_changed.emit((current_health/max_health) * 100)

func set_max_health(value : int):
	if max_health != value:
		var difference = value - max_health
		
		if difference > 0: #Increasing max health heals the same amount
			heal(difference)
		
		max_health = value
		#Stops over heal
		if current_health > max_health: 
			current_health = max_health

		max_health_changed.emit(max_health)

