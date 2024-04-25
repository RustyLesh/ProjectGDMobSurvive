class_name ShellBoss extends EnemyShell
## Base for boss classes

@onready var navigation_agent: NavigationAgent2D = $CharacterBody2D/NavigationAgent2D

var enemy_ai_movement: EnemyMovementAI
var enemy_shell_resource 
var enemy_resource
var spawn_position
var parent
var spawn_animation_node

signal on_boss_death()
signal on_current_hp_changed(current_hp)

func ready():
	entity_type = EntityType.BOSS

func _on_health_died():
	on_boss_death.emit()
	print("boss dead")
	super()

func spawn_enemy(_enemy_resource: EnemyResource, _spawn_position: Vector2, _parent):
	character_body = $CharacterBody2D
	sprite = character_body.get_node("Sprite2D")
	enemy_resource = _enemy_resource
	enemy_shell_resource = _enemy_resource.enemy_shell_resource
	spawn_position = _spawn_position
	drop_pool = enemy_resource.drop_pool
	parent = _parent
	parent.add_child(self)
	set_spawn_position(spawn_position)

	health.init_health(enemy_resource.max_health)

func current_hp_changed(current_hp):
	on_current_hp_changed.emit(current_hp)
