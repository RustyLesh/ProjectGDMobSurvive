extends Resource
class_name OnHitEffect

##0 to 1
@export var _proc_chance: float
var base_res_path: String

func trigger_effect(_enemy: EnemyShell):
	pass

func get_upgrade_string() -> String:
	return "Base on hit effect resource"

func get_save_data() -> Dictionary:
	print("No save resource func data set on hit effect")
	return {"proc_chance": null}

func set_resource_data(data_dict):
	print("No set resource data func set on hit effect")