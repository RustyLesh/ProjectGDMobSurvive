class_name OnKillExplode extends OnKillEffect

@export var size = 50
@export var damage = 10

func _init():
	base_res_path = "res://Resources/Upgrades/On Kill Effects/on_kill_explode.tres"

func trigger_effect(object: Entity):
	BulletHelper.create_explosion_sprite(size, object.position)
	var hit_bodies = BulletHelper.explosion_helper.explode(object.position, size)
	for body in hit_bodies:
		var entity = body.get_parent()
		if entity is Entity:
			print("Explode hit")
			entity.take_damage(damage)

func get_upgrade_string() -> String:
	return str("Enemies explode on death in an area of ", size, " Units dealing ", damage, " damage.")

func get_save_data() -> Dictionary:

	return {
		"base_res_path": base_res_path,
		"size": size,
		"damage": damage,
	}

func set_resource_data(data_dict):
	size = data_dict["size"]
	damage = data_dict["damage"]