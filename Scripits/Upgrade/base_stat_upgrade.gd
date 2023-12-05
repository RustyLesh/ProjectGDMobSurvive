extends Upgrade
class_name BaseStatUpgrade

@export var mod_type: StatMod.StatModType
@export var base_stat_type: BaseStat.BaseStatType

func apply_upgrade(player: Node):
	var statmod := StatMod.new()
	statmod.value = value
	statmod.stat_mod_type = mod_type
	statmod.source = self
	var player_stat_container = player.combat_stat_container
	if player_stat_container is StatContainer:
			player_stat_container.add_mod_to_base_stat(statmod, base_stat_type)

func apply_upgrade_main_menu(player_stat_container: StatContainer):
	var statmod := StatMod.new()
	statmod.value = value
	statmod.stat_mod_type = mod_type
	statmod.source = self
	
	if player_stat_container is StatContainer:
		player_stat_container.add_mod_to_base_stat(statmod, base_stat_type)
	
func remove_upgrade(stat_container: MainMenuStatContainer):
	print("removed", BaseStat.BaseStatType.keys()[base_stat_type])
	if stat_container is StatContainer:
		stat_container.remove_mod_from_base_stat(base_stat_type, self)

func get_upgrade_string() -> String:
	var return_string
	if value >= 0:
		return_string = "+"
	else:
		return_string = "-"
	
	return_string += str(value)
	
	if mod_type == StatMod.StatModType.MULTIPLIER:
		return_string += "%"
		
	return_string += str(" ", BaseStat.BaseStatType.keys()[base_stat_type])
	return return_string
