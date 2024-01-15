extends Upgrade
class_name OnHitEffectUpgrade
#An upgrade that gives the player an effect that occurs when an enemy is hit.

@export var _effect: OnHitEffect

func _init():
	base_res_path = "res://Resources/Upgrades/On Hit Upgrades/base_on_hit_effect_upgrade.tres"
	
func apply_upgrade(player: Node):
	if player is Player:
		player.weapon_manager.apply_on_hit_effect_to_weapons(_effect)

func get_upgrade_string() -> String:
	return _effect.get_upgrade_string()

func get_save_data() -> Dictionary:
	return {
		"effect": _effect.get_save_data(),
		"resource_path": base_res_path,
	}

func set_resource_data(data_dict):
	var effect_data = data_dict["effect"]
	_effect = load(effect_data["resource_path"]).duplicate()
	_effect.set_resource_data(effect_data)
