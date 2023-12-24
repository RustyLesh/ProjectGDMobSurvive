extends Entity
class_name EnemyNode
#Base logic for assembling an enemy from given enemy resource

#@export var enemy_resource = EnemyResource.new()

@onready var player_node: CharacterBody2D = get_tree().get_first_node_in_group(("Player")).player_body

@onready var character_body: CharacterBody2D = $CharacterBody2D
@onready var collision_shape: CollisionShape2D = $CharacterBody2D/CollisionShape2D
@onready var navigation_agent: NavigationAgent2D = $CharacterBody2D/NavigationAgent2D
@onready var sprite: Sprite2D = $CharacterBody2D/Sprite2D

var enemy_ai_movement: EnemyMovementAI

var xp_drop: PackedScene = preload("res://Objects/xp_drop.tscn")
@export var stage_xp_value : float
@export var weapon_xp_value : float

@export var contact_damage: float
var min_move_speed: int = 10

func init_enemy(enemy_resource: EnemyResource):
	sprite.texture = enemy_resource.sprite
	collision_shape.shape = enemy_resource.collision_shape
	collision_shape.position = enemy_resource.collision_pos_offset
	enemy_ai_movement = enemy_resource.enemy_ai_movement
	navigation_agent.max_speed = enemy_resource.move_speed
	stage_xp_value = enemy_resource.stage_xp_value
	weapon_xp_value = enemy_resource.weapon_xp_value
	contact_damage = enemy_resource.contact_damage
	
	if health is Health:
		health.init_health(enemy_resource.max_health)

func _on_health_died():
	#Create Drops
	call_deferred("Spawn_XP")
	queue_free()
	PlayerStats.weapon_xp += weapon_xp_value
	
func Spawn_XP():
	if xp_drop is PackedScene:
		var xpDrop = xp_drop.instantiate()
		xpDrop.XP_Init(stage_xp_value)
		xpDrop.global_position = $CharacterBody2D.global_position
		get_parent().add_child(xpDrop)
		
func deal_damage() -> float:
	return contact_damage

func apply_slow_to_self(value: int, duration: int):
	navigation_agent.max_speed = clamp( navigation_agent.max_speed - value, min_move_speed, 999999)
