extends Upgrade
class_name BaseStatUpgrade
@export var mod_type: StatMod.StatModType
@export var base_stat_type: BaseStat.BaseStatType

func apply_upgrade(player: Node) -> Resource:
	var statmod := StatMod.new()
	statmod.value = value
	statmod.stat_mod_type = mod_type
	var player_stat_container = player.get_node("Stat Container")
	if player_stat_container is StatContainer:
			player_stat_container.add_mod_to_base_stat(statmod, base_stat_type)
	return self
