extends OnHitEffect
class_name SlowOnHit

@export var _duration: int #Seconds
@export var _slow_amount: float

func _init():
	base_res_path = "res://Resources/Upgrades/On Hit Upgrades/base_slow_on_hit_effect.tres"

func trigger_effect(enemy: EnemyShell):
	enemy.apply_slow_to_self(_slow_amount, _duration)

func get_upgrade_string() -> String:
	return str("Slow enemy on hit by: ", _slow_amount, " for", _duration, "seconds.")
	
func get_save_data() -> Dictionary:
	return {
		"duration": _duration,
		"slow_amount": _slow_amount,
		"proc_chance": _proc_chance,
		"resource_path": base_res_path,
	}

func set_resource_data(data_dict):
	_proc_chance = data_dict["proc_chance"]
	_duration = data_dict["duration"]
	_slow_amount = data_dict["slow_amount"]
	
