extends Resource
class_name EnemyResource
#Enemy resource, used in spawn data.

enum EnemyType
{
	GRUNT,
	BOSS
}

@export_category("Enemy Info")
@export var enemy_type: EnemyType
@export var enemy_name : String = "name"
@export var max_health : int = 10
@export var move_speed : int = 100
@export var contact_damage: int

@export_subgroup("Enemy Resources")
@export_subgroup("Scene Resources")
@export var sprite : CompressedTexture2D
@export var spawn_animation : SpriteFrames 
@export var stage_xp_value: float
@export var weapon_xp_value: float
@export var collision_shape: Shape2D
@export var collision_pos_offset: Vector2
@export var drop_pool: Array[DropResource]
#Enemy scene which will use given enemy resource
@export var enemy_base_object: Resource
@export var enemy_ai_movement: EnemyMovementAI
