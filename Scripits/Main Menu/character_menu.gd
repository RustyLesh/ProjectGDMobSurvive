extends Control
class_name CharacterMenu
#Character details menu

@onready var stat_panel: RichTextLabel = $"Stats Scroll Panel/Stats"
@onready var upgrade_panel: RichTextLabel = $"Upgrades Scroll Panel/Upgrades"
@onready var stat_container: MainMenuStatContainer = $"../Stat Container"

func update_ui():
	#Cleartext  panels
	stat_panel.clear()
	upgrade_panel.clear()
	
	for stat in stat_container.base_stats:
		stat_panel.add_text(stat.get_string() + "\n")
	
	for upgrade in PlayerSetup.gear_upgrade_pool:
		upgrade_panel.add_text(upgrade._name + "\n")
		
