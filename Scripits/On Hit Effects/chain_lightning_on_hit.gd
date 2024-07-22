extends OnHitEffect
class_name ChainLightningOnHit

@export var _proc_range: float
@export var _max_chain_count: int
@export var _damage: float
var enemies_in_area: Array[Node2D]
var enemy_proc_buffer: EnemyShell
var enemy_hit

func _init():
	base_res_path = "res://Resources/Upgrades/On Hit Upgrades/base_lightning_effect.tres"

func trigger_effect(enemy: EnemyShell):
	enemies_in_area = BulletHelper.explosion_helper.explode(enemy.character_body.global_position, _proc_range)
	enemy_proc_buffer = enemy
	enemy_hit = enemy

	var pos_array: Array[Vector2]
	
	for i in _max_chain_count:
		if enemies_in_area.size() < 1: #If no enemies are found, end chain effect
			return
		pos_array.append(enemy_hit.character_body.global_position)
		enemies_in_area.shuffle()
		enemy_proc_buffer = enemy_hit
		enemy_hit = enemies_in_area[0].get_parent()
		enemy_hit.take_damage(_damage)
		enemies_in_area = BulletHelper.explosion_helper.explode(enemy.character_body.global_position, _proc_range)
		BulletHelper.on_hit_effects_helper.chain_line_effect(pos_array)

func get_upgrade_string() -> String:
	return str(_proc_chance, " chance to triggure chain lightning, dealing", _damage, " damage." )

func get_save_data() -> Dictionary:
	return {
		"proc_range": _proc_range,
		"max_chain_count": _max_chain_count,
		"damage": _damage,
		"proc_chance": _proc_chance,
		"base_res_path": base_res_path,
	}

func set_resource_data(data_dict):
	_proc_chance = data_dict["proc_chance"]
	_proc_range = data_dict["proc_range"]
	_max_chain_count = data_dict["max_chain_count"]
	_damage = data_dict["damage"]
