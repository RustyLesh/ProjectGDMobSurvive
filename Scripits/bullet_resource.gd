extends Resource
class_name BulletResource

@export var bullet_scene: Resource

func get_bullet_scene() -> Variant:
	var bullet
	bullet = load(bullet_scene.resource_path)
	return bullet

