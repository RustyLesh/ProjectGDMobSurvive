extends Button
class_name StageSelectButton

@export var difficulty: int
@export var enemy_spawns: EnemySpawns
@onready var combat_menu = $"../../"
func _ready():
	pressed.connect(combat_menu.on_mission_select)
	pressed.connect( _on_pressed)

func _on_pressed():
	PlayerSetup.difficulty = difficulty
	PlayerSetup.enemy_spawns = enemy_spawns
