extends Weapon

func init_weapon(base_stats: Array[BaseStat]):
	super(base_stats)
	
	while true:
		for i in 1 + weapon_manager.extra_proj_count:
			var bullet_instance = bullet_scene.instantiate()
			if bullet_instance is Bullet:
				bullet_instance.pierce = weapon_manager.pierce
				bullet_instance.lifetime = weapon_manager.bullet_lifetime
				bullet_instance.on_hit_effects = on_hit_effects
				bullet_instance.base_damage = stat_container.get_stat(BaseStat.BaseStatType.DAMAGE).value
				bullet_instance.speed = weapon_manager.bullet_speed
			weapon_manager.bullet_container.add_child(bullet_instance)
			bullet_instance.global_position = weapon_manager.player_body.global_position

			# Shot angle calculation
			var spread_variation = weapon_manager.spread_variation # Random spread
			var shot_angle = deg_to_rad( randi_range(-spread_variation/2 ,spread_variation / 2))
			bullet_instance.rotate(weapon_manager.player_body.rotation + shot_angle)
		await get_tree().create_timer(weapon_manager.delay, false).timeout
