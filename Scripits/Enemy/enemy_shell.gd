extends Entity
class_name EnemyShell
#Base logic for assembling an enemy from given enemy resource

#@export var enemy_resource = EnemyResource.new()

@onready var player_node: CharacterBody2D = get_tree().get_first_node_in_group(("Player")).player_body
@onready var body: CharacterBody2D = get_node("CharacterBody2D")

var xp_drop: PackedScene = preload("res://Objects/xp_drop.tscn")
@export var stage_xp_value : float
@export var weapon_xp_value : float
@export var slow_colour := Color.BLUE
@export var contact_damage: float

var drop_pool: DropPool
var slow_amount: float
var slow_dutation: int
var min_move_speed: int = 10
var default_move_speed: float

@onready var slow_timer = $SlowTimer as Timer

func _on_health_died():
	call_deferred("roll_drop")
	call_deferred("spawn_XP")
	queue_free()
	PlayerStats.weapon_xp += weapon_xp_value

func spawn_XP():
	if xp_drop is PackedScene:
		var xpDrop = xp_drop.instantiate()
		xpDrop.XP_Init(stage_xp_value)
		xpDrop.global_position = $CharacterBody2D.global_position
		get_parent().add_child(xpDrop)

func roll_drop():
	#return if drop pool doesnt exist
	if drop_pool == null:
		return
		
	var drop_gen = drop_pool.get_drop()
	if drop_gen.size <= 0: #return if drop is empty
		return
		
	if drop_gen["has_rolled_drop"]:
		var drop = drop_gen["drop"]
		drop.global_position = $CharacterBody2D.global_position
		get_parent().add_child(drop)

func set_spawn_position(position: Vector2):
	body.global_position = position

func spawn_enemy(_enemy_resource: EnemyResource, _spawn_position: Vector2, _parent):
	pass

func deal_damage() -> float:
	return contact_damage

func apply_slow_to_self(_value: float, _duration: float):
	pass

func revert_slow():
	pass
