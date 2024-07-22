class_name OnKillEffect extends Resource

var base_res_path: String

func trigger_effect(object: Entity):
	pass

func get_upgrade_string() -> String:
	return str("Empty on kill effect string")

func get_save_data() -> Dictionary:
	print("No save resource func data set on kill effect")
	return {"size": null}

func set_resource_data(data_dict):
	print("No set resource data func set on kill effect")