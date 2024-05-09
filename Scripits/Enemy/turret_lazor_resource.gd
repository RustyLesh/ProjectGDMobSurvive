class_name TurretLazorResource extends EnemyResource

@export var move_speed : int = 100
@export var contact_damage: int
@export var lazor_damage: int = 0
@export var sprite : CompressedTexture2D
@export var collision_shape: Shape2D
@export var collision_pos_offset: Vector2
@export var enemy_ai_movement: EnemyMovementAI

@export var follow_range: int
@export var keep_following: bool
@export var delay_betweeen_shots: float
@export var shoot_duration: float

func _init():
	enemy_scene = preload("res://Objects/Enemy Spawning/enemy_turret_lazor.tscn")

## Runs the given shells instantiate function and returns the created scene
func create_enemy_instance() -> Variant:
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.init_enemy(self)
	return enemy_instance
