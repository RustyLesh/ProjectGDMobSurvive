extends EnemyShellResource
class_name ShellTurretResource

@export var move_speed : int = 100
@export var contact_damage: int
@export var sprite : CompressedTexture2D
@export var spawn_animation : SpriteFrames 
@export var collision_shape: Shape2D
@export var collision_pos_offset: Vector2
@export var follow_range: int
@export var keep_following: bool
@export var bullet_resource: BulletResource
@export var bullet_damage: int
@export var delay_betweeen_shots: float
@export var enemy_ai_movement: EnemyMovementAI

var spawn_scene_path = preload("res://enemy_spawn_animation.tscn")

func _init():
	enemy_shell_scene_path = "res://Objects/Enemy Spawning/enemy_turret.tscn"
	enemy_scene = load(enemy_shell_scene_path)

func instantiate_enemy(enemy_resource: EnemyResource, spawn_position: Vector2, parent) -> Variant:
#	var enemy_scene = load(enemy_shell_scene_path)
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.spawn_enemy(enemy_resource, spawn_position, parent)
	print("Delay in shell resource: ", delay_betweeen_shots)
	return enemy_instance