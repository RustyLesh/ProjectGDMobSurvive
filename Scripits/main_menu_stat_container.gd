extends StatContainer
class_name MainMenuStatContainer

func _ready():
	weapon_manager = WeaponManager.new()
	health = Health.new()
	player_body = PlayerController.new()
	if base_stats.is_empty():
		for base_stat in BaseStat.BaseStatType.keys():
			var stat:= BaseStat.new()
			stat.base_type = BaseStat.BaseStatType[base_stat]
			base_stats.append(stat)
		init_stats()
	
	if PlayerSetup.base_stats.is_empty():
		PlayerSetup.base_stats = base_stats
