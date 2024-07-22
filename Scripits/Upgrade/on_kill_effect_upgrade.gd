class_name OnKillEffectUpgrade extends Upgrade

@export var on_kill_effect: OnKillEffect

func _init():
	base_res_path = "res://Resources/Upgrades/On Kill Effects/base_on_kill_effect.tres"

func apply_upgrade(player: Node2D):
		if player is Player:
			player.on_kill_effect_manager.on_kill_effects.append(on_kill_effect)

func get_upgrade_string() -> String:
	return on_kill_effect.get_upgrade_string()

func get_save_data() -> Dictionary:
	return {
		"on_kill_effect": on_kill_effect.get_save_data(),
		"base_res_path": base_res_path,
	}

func set_resource_data(_data_dict):
	var on_kill_effect_data = _data_dict["on_kill_effect"]
	on_kill_effect = load(on_kill_effect_data["base_res_path"]).duplicate()
	on_kill_effect.set_resource_data(on_kill_effect_data)
