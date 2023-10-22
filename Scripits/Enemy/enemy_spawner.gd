extends Node

@export var enemy_spawn_list: Array[PackedScene]

@export var spawn_rate := .5 # amount per second NOTE: has to be a float value e.g 3.0
@export var number_to_spawn = 1

var delay := 0.0

var spawning_enabled = true

#Spawning coroutine: Checks valid spawn locations, chooses one randomly,
# gets the path child of the chosen node,
# then randomly chooses a point on the path.
#Then spawns the enemy on that choses point.
func spawn_coroutine():
	pass


func clear_spawn_list():
	enemy_spawn_list.clear()
	
func add_enemy(enemy):
	print("Add_enemy")
	enemy_spawn_list.append(enemy)
