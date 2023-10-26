extends TextureProgressBar

@onready var xp_counter = $"Panel/XP Counter"

var xp_manager
func _ready():
	xp_manager = get_parent().get_parent().get_parent().get_node("XP Manager")
	if xp_manager is XPManager:
		xp_manager.xp_changed.connect(update_ui)

func update_ui(current_xp, xp_to_for_level, level):
	if xp_counter is Label:
		xp_counter.text = str(ceil(current_xp)) + " / " + str(ceil(xp_to_for_level))
		value = (current_xp / xp_to_for_level) * 100

