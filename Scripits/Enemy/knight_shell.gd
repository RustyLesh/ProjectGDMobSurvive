class_name KnightShell extends EnemyShell

@onready var navigation_agent: NavigationAgent2D

@export var projectile_scene: PackedScene
@export var animation_player: AnimationPlayer

var attack_damage
var delay_betweeen_attacks: float


func init_enemy(_enemy_resource: EnemyResource):
	super(_enemy_resource)
	animation_player = %AnimationPlayer

	navigation_agent = %NavAgent
	spawn_animation = %SpawnAnimation
	%ColliderShape.disabled = true
	character_body.visible = false
	spawn_animation.visible = true
	#animation_player.play("RESET")

	#Resource setup
	#spawn_animation.sprite_frames = enemy_resource.spawn_sprite_frames
	navigation_agent.max_speed = enemy_resource.move_speed
	contact_damage = enemy_resource.contact_damage
	character_body.speed = enemy_resource.move_speed
	character_body.follow_range = enemy_resource.follow_range

	stage_xp_value = enemy_resource.stage_xp_value
	drop_pool = enemy_resource.drop_pool
	health.init_health(enemy_resource.max_health)

	default_move_speed = character_body.speed

	slow_timer.timeout.connect(revert_slow)

	#Attack setup
	attack_damage = _enemy_resource.attack_damage
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

func shoot(player_position):
	var bullet = projectile_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = character_body.global_position
	bullet.lifetime = 2
	bullet.look_at(player_position)
	bullet.rotate(PI/2)

func _enable_enemy():
	spawn_animation.visible = false
	character_body.visible = true
	%ColliderShape.disabled = false
	character_body.start()
