class_name EnemyShell extends Entity
## Base logic for assembling an enemy from given enemy resource

@onready var player_node: CharacterBody2D = get_tree().get_first_node_in_group(("Player")).player_body

var xp_drop: PackedScene = preload("res://Objects/xp_drop.tscn")
@export var stage_xp_value : float
@export var weapon_xp_value : float
@export var slow_colour := Color.BLUE
@export var contact_damage: float

var enemy_resource

var drop_pool: DropPool
var slow_amount: float
var slow_dutation: int
var min_move_speed: int = 10
var default_move_speed: float

var flash_length: float = 0.3

@onready var slow_timer

func init_enemy(_enemy_resource: EnemyResource):
	init_entity()
	enemy_resource = _enemy_resource
	slow_timer = $SlowTimer as Timer

func _on_health_died():
	is_dead = true
	call_deferred("roll_drop")
	call_deferred("spawn_XP")
	queue_free()
	PlayerStats.weapon_xp += weapon_xp_value

func spawn_XP():
	if xp_drop is PackedScene:
		var xpDrop = xp_drop.instantiate()
		xpDrop.XP_Init(stage_xp_value)
		xpDrop.global_position = character_body.global_position
		get_parent().add_child(xpDrop)

## Chooses random drop from drop pool
func roll_drop():
	#return if drop pool doesnt exist
	if drop_pool == null:
		return
		
	print("Drops size:", drop_pool.drop_pool.size())
	var drop_gen = drop_pool.get_drop()

	if drop_gen.size() <= 0: #return if drop is empty
		return
		
	if drop_gen["has_rolled_drop"]:
		var drop = drop_gen["drop"] #May be able to streamline by not creating a new variable and using directly
		drop.global_position = $CharacterBody2D.global_position
		get_parent().add_child(drop)

func take_damage(damage):
	if health is Health:
		health.take_damage(damage)
		sprite.modulate = damage_flash_color
		await get_tree().create_timer(flash_length).timeout
		sprite.modulate = Color.WHITE		

func spawn_enemy(_enemy_resource: EnemyResource, _spawn_position: Vector2, _parent):
	pass

func deal_damage() -> float:
	return contact_damage

func apply_slow_to_self(_value: float, _duration: float):
	pass

func revert_slow():
	pass
