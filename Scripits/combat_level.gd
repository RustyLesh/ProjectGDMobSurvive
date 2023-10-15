extends Node2D
@onready var player_body_node = $Player.get_node("PlayerBody")
@onready var camera_node = player_body_node.get_node("Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	player_body_node.global_position = $Tile_Map.global_position
	camera_node.reset_smoothing()
