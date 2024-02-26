extends Resource
class_name EnemyShellResource

var enemy_shell_scene_path: String
var enemy_scene

func init_enemy_shell():
    pass

func instantiate_enemy(enemy_resource: EnemyResource, spawn_position: Vector2, parent) -> Variant:
    return null