class_name EnemyResource extends Resource
## Used in spawn data to spawn an enemy.

enum EnemyClass
{
	GRUNT,
	BOSS,
	ELITE,
}

@export var max_health : int = 10
@export var enemy_icon: CompressedTexture2D
@export var enemy_type: EnemyClass
@export var enemy_name : String = "empty_name"
@export var stage_xp_value: float

#@export var weapon_xp_value: float
@export var drop_pool: DropPool
@export var spawn_sprite_frames: SpriteFrames = preload("res://Objects/enemy_spawn_animations/default_spawn.tres")
@export var enemy_scene: PackedScene ## [EnemyShell] Scene to be spawned

## Runs the given shells instantiate function and returns the created scene
func create_enemy_instance() -> Variant:
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.init_enemy(self)
	return enemy_instance
