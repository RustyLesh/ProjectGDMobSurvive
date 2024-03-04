extends EnemyShell
class_name ShellTurret

@onready var character_body = $CharacterBody2D as AITurret
@onready var collision_shape: CollisionShape2D = $CharacterBody2D/CollisionShape2D
@onready var navigation_agent: NavigationAgent2D = $CharacterBody2D/NavigationAgent2D

@onready var sprite: Sprite2D = character_body.get_node("Sprite2D")
@onready var spawn_animation: AnimatedSprite2D
var projectile_scene: Variant

var enemy_ai_movement: EnemyMovementAI
var enemy_shell_resource 
var enemy_resource
var spawn_position
var parent
var spawn_animation_node

func spawn_enemy(_enemy_resource: EnemyResource, _spawn_position: Vector2, _parent):
	enemy_resource = _enemy_resource
	enemy_shell_resource = _enemy_resource.enemy_shell_resource
	spawn_position = _spawn_position
	parent = _parent
	
	
	spawn_animation_node = enemy_shell_resource.spawn_scene_path.instantiate()
	parent.add_child(spawn_animation_node)
	spawn_animation_node.play()
	spawn_animation_node.global_position = spawn_position
	spawn_animation_node.animation_finished.connect(on_spawn_animation_end)

func on_spawn_animation_end():
	spawn_animation_node.queue_free()

	parent.add_child(self)
	set_spawn_position(spawn_position)

	#Resource setup
	sprite.texture = enemy_shell_resource.sprite
	collision_shape.shape = enemy_shell_resource.collision_shape
	collision_shape.position = enemy_shell_resource.collision_pos_offset
	enemy_ai_movement = enemy_shell_resource.enemy_ai_movement
	navigation_agent.max_speed = enemy_shell_resource.move_speed
	contact_damage = enemy_shell_resource.contact_damage
	character_body.speed = enemy_shell_resource.move_speed
	character_body.follow_range = enemy_shell_resource.follow_range
	stage_xp_value = enemy_resource.stage_xp_value
	weapon_xp_value = enemy_resource.weapon_xp_value
	drop_pool = enemy_resource.drop_pool
	projectile_scene = enemy_shell_resource.bullet_resource.get_bullet_scene()
	health.init_health(enemy_resource.max_health)

	default_move_speed = character_body.speed

	slow_timer.timeout.connect(revert_slow)

func apply_slow_to_self(value: float, duration: float):
	character_body.speed = clamp( navigation_agent.max_speed - value, min_move_speed, 999999)
	slow_timer.start(duration)
	sprite.modulate = slow_colour

func revert_slow():
	print("Slow expired")
	character_body.speed = default_move_speed
	sprite.modulate = Color.WHITE

func shoot(player_position):
	var bullet = projectile_scene.instantiate()
	add_child(bullet)
	bullet.global_position = character_body.global_position
	bullet.lifetime = 2
	bullet.look_at(player_position)
	bullet.rotate(PI/2)
