extends Node
class_name UpgradeManager
## For in stage. Tracks upgrade pool, and upgrade points. Lets player spend points on upgrades.

@onready var xp_manager = get_parent().get_node("XP Manager")
@onready var player: Node2D = get_tree().get_first_node_in_group(("Player"))
@onready var player_stat_container = player.combat_stat_container
@onready var player_body 

var upgrade_pool: Array[UpgradeResource] #When upgrades are rolled an choseen, the are removed from here.
var removed_upgrades: Array[UpgradeResource]
var current_upgrade_points : int = 0:
	get:
		return (current_level + bonus_points) - spent_points
		
var spent_points: int = 0
var current_level: int = 0
var specialization_selected:= false

@export var bonus_points: int
@export var reroll_points = 0

@export var number_of_choices: int

signal current_upgrade_points_changed(points: int)
signal on_reroll()
signal on_gained_rerolls()

var max_posible_choices: int = 5 #Hard cap on possible alowed choices. main limit is ui space
		
func _ready():
	if player is Player:
		player.on_player_death.connect(on_player_death)
	xp_manager = $"../XP Manager"
	if xp_manager is XPManager:
		xp_manager.on_level.connect(level_changed)
		
	upgrade_pool = PlayerSetup.selected_upgrades.duplicate()
	reset_upgrade_uses()
	roll_upgrade_options()
	
func level_changed(level: int):
	current_level = level
	current_upgrade_points_changed.emit(current_upgrade_points)

func get_upgrade(choice: int) -> UpgradeResource:
	if !specialization_selected:
		return PlayerSetup.weapon_resource.specializations[choice - 1]

	if upgrade_pool.size() > 0:
		return upgrade_pool[upgrade_pool.size() - choice]

	return null


func select_upgrade(choice: int):
	# Specialization select
	if !specialization_selected:
		for upgrade in PlayerSetup.weapon_resource.specializations[choice - 1].upgrades:
			upgrade.apply_upgrade(player)
	
		
		if PlayerSetup.weapon_resource.specializations[choice - 1].added_upgrades.size() > 0:
			for upgrade in PlayerSetup.weapon_resource.specializations[choice - 1].added_upgrades:
				upgrade_pool.append(upgrade)
				print("if hit")
		specialization_selected = true
		roll_upgrade_options()
		return

	if current_upgrade_points > 0:
		# Get selected upgrade and remove it from the pool if no uses remain
		var selected_upgrade: UpgradeResource = upgrade_pool[upgrade_pool.size() - (choice)]
		if selected_upgrade.current_uses >=  selected_upgrade._max_uses - 1:
			removed_upgrades.append(upgrade_pool.pop_at(upgrade_pool.size() - (choice)))
		else:
			selected_upgrade.current_uses += 1
		
		# Apply 
		for upgrade in selected_upgrade.upgrades:
			upgrade.apply_upgrade(player)

		#Check if there are any added upgrades and if this is the first time applying the selecting upgrade.
		if selected_upgrade.added_upgrades.size() > 0 && selected_upgrade.current_uses == 0:
			print("size", selected_upgrade.added_upgrades.size())
			upgrade_pool.append_array(selected_upgrade.added_upgrades)
		spent_points += 1
		current_upgrade_points_changed.emit(current_upgrade_points)
		
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

func roll_upgrade_options():
	upgrade_pool.shuffle()
	on_reroll.emit()
	
func print_upgrade_option_names(): #Prints to console the names of upgrades from upgrade options array
	if upgrade_pool.size() >= number_of_choices:
		for i in range(upgrade_pool.size()-1, upgrade_pool.size()-(number_of_choices + 1), -1):
			print(upgrade_pool[i]._name)
	else:
		for upgrade in upgrade_pool:
			print(upgrade._name)

func print_upgrade_pool_names(): #Prints to console the names of upgrades from upgrade options array
	print("manager pool")
	for upgrade in upgrade_pool:
		print(upgrade._name)
	
	print("player setup pool")
	for upgrade in PlayerSetup.selected_upgrades:
		print(upgrade._name)

func reset_upgrade_uses(): #Reset resource uses to 0
	if removed_upgrades.size() > 0:
		for upgrade in removed_upgrades:
			if upgrade is UpgradeResource:
				upgrade.current_uses = 0
		
	if upgrade_pool.size() > 0:
		for upgrade in upgrade_pool:
			if upgrade is UpgradeResource:
				upgrade.current_uses = 0

func on_player_death(): 
	reset_upgrade_uses()

func add_reroll_points(value: int):
	reroll_points += value
	on_gained_rerolls.emit()
