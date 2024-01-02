extends Resource
class_name OnHitEffect

@export var _proc_chance: float
var base_res_path: String

func get_upgrade_string() -> String:
	return "Base on hit effect resource"

func trigger_effect(_enemy: EnemyNode):
	pass

func get_save_data() -> Dictionary:
	return {"proc_chance": _proc_chance}
