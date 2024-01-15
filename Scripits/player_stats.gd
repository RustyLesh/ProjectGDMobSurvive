extends Node

var weapon_xp: float
var player_xp: float

@onready var sprite_node: Sprite2D = $Sprite2D
@export var test_resource: TestResource
var test_resource_loaded

const FILE_NAME = "user://player_stats.save"

func save():
	print("player stats saved")
	var save_dict = {
		"weapon_xp": weapon_xp,
		"test_resource": test_resource.get_save_data(),
		"player_xp": player_xp,
	}
	return {
		"file_name": FILE_NAME,
		"data": save_dict
	}

func end_of_stage():
	player_xp += weapon_xp
	PlayerSetup.weapon.weapon_xp += weapon_xp
	weapon_xp = 0

	
func load_data():
	test_resource_loaded = TestResource.new()
	var data = SaveManager.load_file(FILE_NAME)
	var res_data = data["test_resource"]
	player_xp = data["player_xp"]
	sprite_node.texture = load(res_data["sprite_texture"])

	test_resource_loaded.value = res_data["value"]
	test_resource_loaded.sprite_texture = load(res_data["sprite_texture"])
