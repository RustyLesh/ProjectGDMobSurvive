extends Resource
class_name Upgrade
#Base upgrade class

var source_type: GearResource.GearType
var base_res_path: String

func apply_upgrade(_player: Node2D):
	pass

func apply_upgrade_main_menu(stat_container: StatContainer, gear_type: GearResource.GearType):
	pass
	
func remove_upgrade(stat_container: StatContainer, gear_type: GearResource.GearType):
	pass

func get_upgrade_string() -> String:
	return "Empty upgrade string"

func get_save_data() -> Dictionary:
		print("Upgrade save data func not set")
		return {"base_res_path": base_res_path}

func set_resource_data(_data_dict):
	print("Upgrade set data func not set")
