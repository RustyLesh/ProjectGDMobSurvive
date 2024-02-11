extends Resource
#Used in enemy spawn manager to spawn enemies

class_name SpawnDataResource

@export var time_start: int
@export var time_end: int
@export var enemy_resource: EnemyResource
@export var enemy_amount: int
@export var spawn_delay: int

#Default high value to spawn immediatly on time start
var spawn_delay_counter := 9999

func get_enemy_instance(_enemy_resource: EnemyResource, spawn_position: Vector2, parent) -> Variant:
	return enemy_resource.get_enemy_instance(_enemy_resource, spawn_position, parent)

func get_enemy_shell_resource() -> EnemyShellResource:
	return enemy_resource.enemy_shell_resource
