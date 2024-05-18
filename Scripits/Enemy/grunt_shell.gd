class_name GruntShell extends EnemyShell

@onready var collision_shape: CollisionShape2D 
@onready var navigation_agent: NavigationAgent2D

func init_enemy(_enemy_resource: EnemyResource):
	super(_enemy_resource)
	collision_shape = %ColliderShape
	navigation_agent = %NavAgent
	spawn_animation = %SpawnAnimation
	collision_shape.disabled = true
	character_body.visible = false
	spawn_animation.visible = true
	
	#Resource setup
	sprite.texture = enemy_resource.sprite
	collision_shape.shape = enemy_resource.collision_shape
	collision_shape.position = enemy_resource.collision_pos_offset
	navigation_agent.max_speed = enemy_resource.move_speed
	contact_damage = enemy_resource.contact_damage
	character_body.speed = enemy_resource.move_speed
	
	stage_xp_value = enemy_resource.stage_xp_value
	drop_pool = enemy_resource.drop_pool
	health.init_health(enemy_resource.max_health)

	default_move_speed = character_body.speed

	slow_timer.timeout.connect(revert_slow)

	#Spawn
	spawn_animation.play()
	await spawn_animation.animation_finished
	_enable_enemy()

func apply_slow_to_self(value: float, duration: float):
	character_body.speed = clamp( navigation_agent.max_speed - value, min_move_speed, 999999)
	slow_timer.start(duration)
	sprite.modulate = slow_colour

func revert_slow():
	character_body.speed = default_move_speed
	sprite.modulate = Color.WHITE

func _enable_enemy():
	spawn_animation.visible = false
	character_body.visible = true
	%ColliderShape.disabled = false
	character_body.start()
