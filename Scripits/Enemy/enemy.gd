extends Entity
class_name Enemy
@export var enemy_resource = EnemyResource.new()
@onready var sprite_node = $Body/Sprite2D

var xp_drop: PackedScene = preload("res://Objects/xp_drop.tscn")
@export var xp_value : float = 10
@export var damage: float = 10
func _init():
	entity_type = EntityType.GRUNT

func _on_health_died():
	#Create Drops
	call_deferred("Spawn_XP")
	queue_free()

func _ready():
	sprite_node.texture = enemy_resource.sprite
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
