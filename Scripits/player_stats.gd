extends Node

var weapon_xp: float
var player_xp: float

var highest_stage_completed = 0

@onready var sprite_node: Sprite2D = $Sprite2D

const FILE_NAME = "user://player_stats.save"

func end_of_stage():
	player_xp += weapon_xp
	PlayerSetup.weapon_resource.weapon_xp += weapon_xp
	weapon_xp = 0

func save():
	print("player stats saved")
	var save_dict = {
		"player_xp": player_xp,
		"highest_stage_completed": highest_stage_completed,
	}
	return {
		"file_name": FILE_NAME,
		"data": save_dict
	}

func load_data():
	var data = SaveManager.load_file(FILE_NAME)
	player_xp = data["player_xp"]
	highest_stage_completed = data.get("highest_stage_completed")

	if highest_stage_completed == null:
		highest_stage_completed = 0
