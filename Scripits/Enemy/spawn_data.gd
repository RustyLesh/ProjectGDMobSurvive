@tool
@icon("res://Art/Inspector Icons/Square32x32_white.png")
class_name SpawnDataResource extends Resource
## Used in [EnemySpawnManager] to spawn enemies
## Data for spawning enemies. Calls the enemyresource to get an instance of the enemy scene. [EnemyShell]

enum SpawnPattern{
	CENTER,
	CLUSTER_RANDOM,
	RANDOM_SINGLE,
}

@export var time_start: int
@export var one_shot: bool: 
	set(value):
		one_shot = value
		notify_property_list_changed()

@export var duration: int
@export var wave_delay: int 
@export var amount: int # How many to spawn at once
@export var enemy_resource: EnemyResource
@export var spawn_pattern : SpawnPattern
var spawn_animation_node: AnimatedSprite2D

var time_end: get = get_time_end
var has_spawned = false

#Default high value to spawn immediatly on time start
## Keeps track of time between spawns
var spawn_delay_counter := 9999

func spawn_enemy(spawn_position: Vector2, parent)-> EnemyShell:
	#Spawn animation init
	has_spawned = true

	#spawn Enemy
	var enemy_instance = enemy_resource.create_enemy_instance()
	enemy_instance.position = spawn_position
	parent.add_child(enemy_instance)
	return enemy_instance

func get_time_end() -> int:
	return time_start + duration

func _validate_property(property: Dictionary):
	if (property.name == "duration" || property.name == "wave_delay") and one_shot:
		property.usage = PROPERTY_USAGE_NO_EDITOR
		duration = 1