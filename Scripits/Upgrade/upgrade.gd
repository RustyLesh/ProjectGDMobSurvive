extends Resource
class_name Upgrade
#Base upgrade class

var source_type: GearResource.GearType
var base_res_path: String

func apply_upgrade(_player: Node):
	pass

func apply_upgrade_main_menu(stat_container: StatContainer, gear_type: GearResource.GearType):
	pass
	
func remove_upgrade(stat_container: StatContainer, gear_type: GearResource.GearType):
	pass

func get_upgrade_string() -> String:
	return "empty"

func get_save_data() -> Dictionary:
	return {}

func set_resource_data(_data_dict):
	print("Upgrade class set data")
