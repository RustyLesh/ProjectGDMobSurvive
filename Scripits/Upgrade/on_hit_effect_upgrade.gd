extends Upgrade
class_name OnHitEffectUpgrade

@export var effect: OnHitEffect

func apply_upgrade(player: Node):
	if player is Player:
		effect.value = value
		player.weapon_manager.apply_on_hit_effect_to_weapons(effect)
