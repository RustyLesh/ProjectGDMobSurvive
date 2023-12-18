extends Node2D
#Base for any scene where player fights enemies

@onready var player_body_node = $Player.get_node("PlayerBody")
@onready var camera_node = player_body_node.get_node("Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	if camera_node is Camera2D:
		player_body_node.global_position = $Tile_Map.global_position
		await get_tree().create_timer(.5).timeout
		camera_node.position_smoothing_enabled = true

