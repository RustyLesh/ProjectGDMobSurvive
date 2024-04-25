extends Node
## Autoload 
## Manages inputs for debugging

@onready var player: Player = %Player
@onready var upgrade_manager: UpgradeManager = %"Upgrade Manager"

func _input(event):

	if event.is_action_pressed("debug_1"):
		player.take_damage(10000)
	
	if event.is_action_pressed("debug_2"):
		player.xp_pickup(100)
	
	if event.is_action_pressed("debug_3"):
		upgrade_manager.add_reroll_points(10)
