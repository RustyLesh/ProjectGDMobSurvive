extends Resource
class_name EnemyResource
#Enemy resource, used in spawn data.

enum EnemyType
{
	GRUNT,
	BOSS,
	ELITE,
}

@export_category("Enemy Info")
@export var enemy_icon: CompressedTexture2D
@export var enemy_type: EnemyType
@export var enemy_name : String = "empty_name"
@export var max_health : int = 10
@export var stage_xp_value: float
@export var weapon_xp_value: float
@export var drop_pool: DropPool

@export var enemy_shell_resource: EnemyShellResource

func get_enemy_instance(enemy_resource: EnemyResource, spawn_position: Vector2, parent) -> Variant:
	return enemy_shell_resource.instantiate_enemy(enemy_resource,spawn_position,parent)


