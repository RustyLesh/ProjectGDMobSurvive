extends Resource
class_name Upgrade
#Base upgrade class

@export var value: float 
var source: Resource

func apply_upgrade(player: Node):
	pass
func apply_upgrade_main_menu(player_stat_container: StatContainer):
	pass
	
func remove_upgrade(stat_container: MainMenuStatContainer):
	pass

func get_upgrade_string() -> String:
	return "empty"
