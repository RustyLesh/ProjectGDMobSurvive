extends Node

@onready var player_stat_container: Node = get_tree().get_first_node_in_group(("Player")).combat_stat_container
@onready var upgrade_mamanger: Node = get_parent().get_node("Upgrade Manager")

func _input(event):
	if event.is_action_pressed("shoot"):
		if upgrade_mamanger is UpgradeManager:
			upgrade_mamanger.roll_upgrade_options()
	
	if event.is_action_pressed("action_1"):
		if upgrade_mamanger is UpgradeManager:
			upgrade_mamanger.select_upgrade(1)

	if event.is_action_pressed("action_2"):
		if upgrade_mamanger is UpgradeManager:
			upgrade_mamanger.select_upgrade(2)

	if event.is_action_pressed("action_3"):
		if upgrade_mamanger is UpgradeManager:
			upgrade_mamanger.select_upgrade(3)
