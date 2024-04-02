extends StatContainer
class_name CombatStatContainer
#Player stat container to be used in combat scene

func _ready():
	base_stats = PlayerSetup.base_stats.duplicate()
	weapon_manager = $"../Weapon Manager"
	health = $"../Health"
	player_body = $"../PlayerBody"
	
	if health is Health:
		health.init_health(get_stat(BaseStat.BaseStatType.MAX_LIFE).value)
		
	init_stat_signals()
