extends Entity
class_name EnemyNode
@export var enemy_resource = EnemyResource.new()

@onready var player_node: CharacterBody2D = get_tree().get_first_node_in_group(("Player")).player_body

@onready var character_body: CharacterBody2D = $CharacterBody2D
@onready var collision_shape: CollisionShape2D = $CharacterBody2D/CollisionShape2D
@onready var navigation_agent: NavigationAgent2D = $CharacterBody2D/NavigationAgent2D
@onready var sprite: Sprite2D = $CharacterBody2D/Sprite2D

var enemy_ai_movement: EnemyMovementAI

var xp_drop: PackedScene = preload("res://Objects/xp_drop.tscn")
@export var xp_value : float = 10
@export var damage: float = 10

func init_enemy(enemy_resource: EnemyResource):
	sprite.texture = enemy_resource.sprite
	collision_shape.shape = enemy_resource.collision_shape
	collision_shape.position = enemy_resource.collision_pos_offset
	enemy_ai_movement = enemy_resource.enemy_ai_movement

func _on_health_died():
	#Create Drops
	call_deferred("Spawn_XP")
	queue_free()

func _ready():
	if health is Health:
		health.init_health(enemy_resource.max_health)
	
func Spawn_XP():
	if xp_drop is PackedScene:
		var xpDrop = xp_drop.instantiate()
		xpDrop.XP_Init(xp_value)
		xpDrop.global_position = $Body.global_position
		get_parent().add_child(xpDrop)
		
func deal_damage() -> float:
	return damage

