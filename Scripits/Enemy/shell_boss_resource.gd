extends EnemyShellResource
class_name ShellBossResource
@export var hp_bar_texture_resource: Resource
@export var difficulty: int
var name: String

func _init():
	enemy_shell_scene_path = "res://Objects/Enemy Spawning/Bosses/boss_totem.tscn"
	enemy_scene = load(enemy_shell_scene_path)
	difficulty = 1

func instantiate_enemy(enemy_resource: EnemyResource, spawn_position: Vector2, parent) -> Variant:
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.spawn_enemy(enemy_resource, spawn_position, parent)
	return enemy_instance