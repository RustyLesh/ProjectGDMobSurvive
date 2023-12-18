extends Label
class_name UpgradePointsCounter
#HUD element to show how many upgrade points for player to spend

func _ready():
	var upgrade_manager = get_parent().get_parent().get_node("Upgrade Manager")
	if upgrade_manager is UpgradeManager:
		upgrade_manager.current_upgrade_points_changed.connect(updeate_label)
		updeate_label(upgrade_manager.current_upgrade_points)

func updeate_label(points : int):
	text = str("Pts: ",points)
	
