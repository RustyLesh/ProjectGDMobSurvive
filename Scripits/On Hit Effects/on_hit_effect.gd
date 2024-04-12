extends Resource
class_name OnHitEffect

##0 to 1
@export var _proc_chance: float
var base_res_path: String

func get_upgrade_string() -> String:
	return "Base on hit effect resource"

func trigger_effect(_enemy: EnemyShell):
	pass

func get_save_data() -> Dictionary:
	return {"proc_chance": _proc_chance}
