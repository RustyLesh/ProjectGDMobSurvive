extends Control
class_name EndScreen
@onready var player: Node = get_tree().get_first_node_in_group(("Player")) as Player
@onready var title_label = $"Info Label" as Label

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	title_label.text = "Stage Complete"
	player.on_player_death.connect(on_player_death)
	
func on_player_death():
	get_tree().paused = true
	title_label.text = "You Died :c"
	title_label.text = str("Weapon: XP: ", PlayerStats.weapon_xp)
	visible = true

func on_stage_win():
	get_tree().paused = true
	title_label.text = "You Win!"
	title_label.text = str("Weapon: XP: ", PlayerStats.weapon_xp)
	visible = true	

func return_to_main_menu():
	GameData.go_to_main_menu()
