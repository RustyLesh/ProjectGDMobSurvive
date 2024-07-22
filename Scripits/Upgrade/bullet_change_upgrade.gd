class_name BulletChangeUpgrade extends Upgrade

@export var bullet_resource: BulletResource 

func _init():
	base_res_path = "res://Resources/base_bullet_change_upgrade.tres"

func apply_upgrade(player: Node):
		if player is Player:
			player.weapon_inst.bullet_scene = bullet_resource.get_bullet_scene()

func apply_upgrade_main_menu(_stat_container: StatContainer, _gear_type: GearResource.GearType):
	print("bullet change applied")
	PlayerSetup.weapon_bullet_resource = bullet_resource

func get_upgrade_string() ->String:
	return "Replaces bullet wtih this one"

func get_save_data() -> Dictionary:
	return {
		"bullet_resource": bullet_resource.resource_path,
		"base_res_path": base_res_path,
	}

func set_resource_data(data_dict):
	bullet_resource = load(data_dict["bullet_resource"])