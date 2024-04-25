class_name EnemyShellResource extends Resource
## Base resource for enemy scenes

var enemy_shell_scene_path: String
var enemy_scene

func init_enemy_shell():
    pass

func instantiate_enemy(enemy_resource: EnemyResource, spawn_position: Vector2, parent) -> Variant:
    return null