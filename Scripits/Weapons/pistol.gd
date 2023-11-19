extends Weapon

@export var shot_angle_variation = 15

func init_weapon():
	while true:
		for i in weapon_manager.base_extra_proj + 1 + weapon_manager.extra_proj_count:
			var bullet_instance = bullet_scene.instantiate()
			if bullet_instance is Bullet:
				bullet_instance.lifetime = weapon_manager.bullet_lifetime
			weapon_manager.bullet_container.add_child(bullet_instance)
			bullet_instance.global_position = weapon_manager.player_body.global_position
			var shot_angle = deg_to_rad( randi_range(-shot_angle_variation/2 ,shot_angle_variation / 2))
			bullet_instance.rotate(weapon_manager.player_body.rotation + shot_angle)
		await get_tree().create_timer(weapon_manager.delay).timeout
