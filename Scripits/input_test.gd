extends Node

@onready var player_stat_container: Node = get_tree().get_first_node_in_group(("player")).get_node("Stat Container")

func _input(event):
	if event.is_action_pressed("shoot"):
		var statmod := StatMod.new()
		statmod.value = 1
		statmod.stat_mod_type = StatMod.StatModType.FLAT
		if player_stat_container is StatContainer:
			player_stat_container.add_mod_to_base_stat(statmod, BaseStat.BaseStatType.FIRE_RATE)

