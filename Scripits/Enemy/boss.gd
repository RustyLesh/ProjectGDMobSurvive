class_name ShellBoss extends EnemyShell
## Base for boss classes

@onready var navigation_agent: NavigationAgent2D = %NavAgent
@onready var collision_shape: CollisionShape2D 

signal on_boss_death()
signal on_current_hp_changed(current_hp)

func ready():
	entity_type = EntityType.BOSS

func _on_health_died():
	on_boss_death.emit()
	print("boss dead")
	super()

func init_enemy(_enemy_resource: EnemyResource):
	super(_enemy_resource)
	navigation_agent = %NavAgent
	spawn_animation = %SpawnAnimation
	collision_shape = %ColliderShape

	collision_shape.disabled = true
	character_body.visible = false
	spawn_animation.visible = true

	#Resource setup
	stage_xp_value = enemy_resource.stage_xp_value
	drop_pool = enemy_resource.drop_pool
	health.init_health(enemy_resource.max_health)
	
	#Spawn
	spawn_animation.play()
	await spawn_animation.animation_finished
	_enable_enemy()


func current_hp_changed(current_hp):
	on_current_hp_changed.emit(current_hp)

func _enable_enemy():
	spawn_animation.visible = false
	character_body.visible = true
	%ColliderShape.disabled = false
	character_body.start()
