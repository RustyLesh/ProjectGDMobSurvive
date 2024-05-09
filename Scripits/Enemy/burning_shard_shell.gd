class_name  BurningShardShell extends EnemyShell

@onready var navigation_agent: NavigationAgent2D

func init_enemy(_enemy_resource: EnemyResource):
	super(_enemy_resource)
	navigation_agent = %NavAgent

	#Resource setup	
	navigation_agent.max_speed = enemy_resource.move_speed
	contact_damage = enemy_resource.contact_damage
	character_body.speed = enemy_resource.move_speed
	
	stage_xp_value = enemy_resource.stage_xp_value
	drop_pool = enemy_resource.drop_pool
	health.init_health(enemy_resource.max_health)

	default_move_speed = character_body.speed

	slow_timer.timeout.connect(revert_slow)
