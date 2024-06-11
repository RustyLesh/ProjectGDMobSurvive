@tool
@icon("res://Art/Inspector Icons/Square32x32_red.png")
class_name BossSpawnDataResource extends SpawnDataResource

@export var difficulty:= 0
@export var hp_bar_texture_resource: Resource
var boss_name: String

func spawn_enemy(spawn_position: Vector2, parent)-> EnemyShell:
	has_spawned = true
	var enemy_instance = enemy_resource.create_enemy_instance()
	enemy_instance.position = spawn_position
	enemy_instance.character_body.difficulty = difficulty
	parent.add_child(enemy_instance)
	return enemy_instance

func _init():
	rank = EnemyRank.BOSS