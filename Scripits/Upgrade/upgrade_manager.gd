extends Node
class_name UpgradeManager

#Tracks upgrade pool

@onready var xp_manager = get_parent().get_node("XP Manager")
@onready var  player: Node = get_tree().get_first_node_in_group(("player"))
@onready var player_stat_container = player.get_node("Stat Container")
@onready var player_body 

@export var base_uprgade_pool: Array[UpgradeResource] #Starting upgrades, should not be changed in game
var upgrade_pool: Array[UpgradeResource] #When upgrades are rolled an choseen, the are removed from here.

var current_upgrade_points : int = 10 :
	set(value):
		current_upgrade_points = value
		current_upgrade_points_changed.emit(current_upgrade_points)
		
var spent_points: int = 0
var current_level: int = 0
var bonus_points: int = 0

@export var number_of_choices: int = 3

signal current_upgrade_points_changed(points: int)
signal on_reroll()

var max_posible_choices: int = 5 #Hard cap on possible alowed choices. main limite is ui space
		
func _ready():
	xp_manager = $"../XP Manager"
	if xp_manager is XPManager:
		xp_manager.on_level.connect(level_changed)
		
	init_upgrade_pool()
	roll_upgrade_options()
	
func level_changed(level: int):
	current_level = level
	current_upgrade_points = (current_level + bonus_points) - spent_points

func get_upgrade(choice: int) -> UpgradeResource:
	if upgrade_pool.size() > 0:
		return upgrade_pool[upgrade_pool.size() - choice]
	return null

func select_upgrade(choice: int):
	if current_upgrade_points > spent_points:
		var selected_upgrade: UpgradeResource = upgrade_pool[upgrade_pool.size() - (choice)]
		if selected_upgrade.current_uses >=  selected_upgrade.max_uses - 1:
			upgrade_pool.pop_at(upgrade_pool.size() - (choice))
		else:
			selected_upgrade.current_uses += 1
		
		selected_upgrade.upgrade.apply_upgrade(player_stat_container)
		spent_points += 1
		
		roll_upgrade_options()

func get_upgrade_options() -> Array[UpgradeResource]:
	var options_return: Array[UpgradeResource]
	if upgrade_pool.size() >= number_of_choices:
		for i in range(upgrade_pool.size()-1, upgrade_pool.size()-(number_of_choices + 1), -1):
			options_return.append(upgrade_pool[i])
	else:
		for upgrade in upgrade_pool:
			options_return.append(upgrade)
	return options_return

func init_upgrade_pool(): #copy over base upgrades and add upgrades from other sources to the upgrade pool
	upgrade_pool = base_uprgade_pool.duplicate()
	#add upgrades from other sources to upgrade pool here

func roll_upgrade_options():
	upgrade_pool.shuffle()
	print_upgrade_names()
	on_reroll.emit()
	
func print_upgrade_names(): #from upgrade options
	if upgrade_pool.size() >= number_of_choices:
		print("Upgrades:")
		for i in range(upgrade_pool.size()-1, upgrade_pool.size()-(number_of_choices + 1), -1):
			print(upgrade_pool[i].name)
	else:
		for upgrade in upgrade_pool:
			print(upgrade.name)
