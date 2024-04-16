extends Control
class_name EndScreen
@onready var player: Node = get_tree().get_first_node_in_group(("Player")) as Player
@onready var title_label = $"Title" as Label
@onready var info_label = $"Info Label" as Label
@onready var gear_menu = $"Gear Menu" as EndOfCombatGearMenu

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	title_label.text = "Stage Complete"
	player.on_player_death.connect(on_player_death)
	
func on_player_death():
	title_label.text = "You Died :c"
	update_infobox()

func on_stage_win():
	title_label.text = "You Win!"
	update_infobox()

func return_to_main_menu():
	GameData.go_to_main_menu()

func update_infobox():
	gear_menu.refresh_item_list()
	info_label.text = str("Weapon XP: ", PlayerStats.weapon_xp, "\n")
	info_label.text += str("Number of items gained: ", PlayerSetup.gear_drops.size())
	get_tree().paused = true
	visible = true	
