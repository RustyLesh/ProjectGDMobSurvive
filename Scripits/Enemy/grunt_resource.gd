class_name ShellGruntResource extends EnemyResource

@export_category("Grunt Resource")
@export var move_speed : int = 100
@export var contact_damage: int
@export var sprite : CompressedTexture2D
@export var collision_shape: Shape2D
@export var collision_pos_offset: Vector2
@export var enemy_ai_movement: EnemyMovementAI

func _init():
	enemy_scene = preload("res://Objects/Enemy Spawning/enemy_grunt.tscn")
