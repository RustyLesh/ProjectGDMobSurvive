extends TextureProgressBar
class_name HudXP
#Keeps track of player xp in combat

@onready var xp_counter = $"Panel/XP Counter"

var xp_manager

func _ready():
	xp_manager = get_parent().get_parent().get_parent().get_node("XP Manager")
	if xp_manager is XPManager:
		xp_manager.on_xp_changed.connect(update_xp_bar)
	value = 0

func update_xp_bar(current_xp, xp_to_for_level, level):
	value = (current_xp / xp_to_for_level) * 100

