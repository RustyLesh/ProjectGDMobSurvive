extends Label
class_name UpgradePointsCounter

func _ready():
	var upgrade_manager = get_parent().get_parent().get_node("Upgrade Manager")
	if upgrade_manager is UpgradeManager:
		upgrade_manager.current_upgrade_points_changed.connect(updeate_label)
		updeate_label(upgrade_manager.current_upgrade_points)

func updeate_label(points : int):
	text = str("Pts: ",points)
	
