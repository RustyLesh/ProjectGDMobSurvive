extends Control
class_name CharacterMenu
#Character details menu

@onready var stat_panel: RichTextLabel = $"Stats Scroll Panel/Stats"
@onready var accomplishments: RichTextLabel = $"Accomplishments Scroll/List"
@onready var stat_container: MainMenuStatContainer = $"../Stat Container"

func update_ui():
	#Cleartext  panels
	stat_panel.clear()
	accomplishments.text = ""
	
	for stat in stat_container.base_stats:
		stat_panel.add_text(stat.get_string() + "\n")

	accomplishments.text += str("Highest stage completed: ", PlayerStats.highest_stage_completed, "\n")
	accomplishments.text += str("Total Player XP: ", PlayerStats.player_xp)
		
