@tool
class_name SpawnDataResource extends Resource
## Used in [EnemySpawnManager] to spawn enemies
## Data for spawning enemies. Calls the enemyresource to get an instance of the enemy scene. [EnemyShell]

enum SpawnType{
	REPEAT,
	ONE_SHOT
}

enum SpawnPattern{
	SINGLE_CENTER,
	CLUSTER_RANDOM,
	RANDOM,
}

@export var time_start: int
@export var has_duration: bool
@export var duration: int
@export var wave_delay: int
@export var enemy_resource: EnemyResource
@export var spawn_type: SpawnType
var spawn_animation_node: AnimatedSprite2D

var time_end: get = get_time_end
var has_spawned = false

#Default high value to spawn immediatly on time start
## Keeps track of time between spawns
var spawn_delay_counter := 9999

func spawn_enemy(spawn_position: Vector2, parent):
	#Spawn animation init
	has_spawned = true
	# spawn_animation_node = AnimatedSprite2D.new() #TODO: Instantiate a premade AnimatedSprite2D node.
	# spawn_animation_node.sprite_frames = enemy_resource.spawn_sprite_frames
	# parent.add_child(spawn_animation_node)
	# spawn_animation_node.position = spawn_position
	# spawn_animation_node.play()
	# await spawn_animation_node.animation_finished
	# spawn_animation_node.queue_free()

	#spawn Enemy
	var enemy_instance = enemy_resource.create_enemy_instance()
	enemy_instance.position = spawn_position
	parent.add_child(enemy_instance)

func get_time_end() -> int:
	return time_start + duration
