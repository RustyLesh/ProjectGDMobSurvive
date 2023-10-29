extends Node

@onready var xp_manager = get_parent().get_node("XP Manager")
@onready var  player: Node2D = get_tree().get_nodes_in_group(("player"))[0]
@onready var player_body 

@export var upgrade_pool: Array[Upgrade_Resource]

var current_upgrade_points : int = 0
var spent_points: int = 0
var current_level: int = 0
var bonus_points: int = 0
func _ready():
	xp_manager = get_parent().get_parent().get_parent().get_node("XP Manager")
	if xp_manager is XPManager:
		xp_manager.xp_changed.connect(level_changed)

func level_changed(level: int):
	current_level = level
	current_upgrade_points = (current_level + bonus_points) - spent_points

func upgrade():
	spent_points += 1
