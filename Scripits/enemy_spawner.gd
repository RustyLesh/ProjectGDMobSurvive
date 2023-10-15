extends Node
@export var valid_spawn_locations: Array[Marker2D]
const Enemy = preload("enemy.gd")
@onready var enemy_container = $EnemyContainer

@export var enemy_spawn_list: Array[PackedScene]

@export var spawn_rate := .5 # amount per second NOTE: has to be a float value e.g 3.0
@export var number_to_spawn = 1
var delay := 0.0

var spawning_enabled = true

#Adds all spawn check marker2D nodes to an array.
func _ready():
	for notifier_node in get_children():
		if(notifier_node is Marker2D):
			valid_spawn_locations.append(notifier_node)
			notifier_node.connect("state_changed", _on_visible_on_screen_notifier_2d_state_changed)
	delay = 1 / spawn_rate
	spawn_coroutine()

#Spawning coroutine: Checks valid spawn locations, chooses one randomly,
# gets the path child of the chosen node,
# then randomly chooses a point on the path.
#Then spawns the enemy on that choses point.
func spawn_coroutine():
	await get_tree().create_timer(0.01).timeout #start delay
	while true:
		if(valid_spawn_locations.size() > 0 && spawning_enabled && enemy_spawn_list.size() > 0):
			var enemy_instance = enemy_spawn_list.pick_random().instantiate()
			enemy_container.add_child(enemy_instance)
			
			var rng = RandomNumberGenerator.new()
			var chosen_spawn = valid_spawn_locations.pick_random().get_node("Path2D").get_node("PathFollow2D")
			rng.randomize()
			
			chosen_spawn.progress_ratio = rng.randf_range(0,1)
			enemy_instance.get_node("Body").global_position = chosen_spawn.global_position
			
		print(enemy_spawn_list.size())
		await get_tree().create_timer(delay).timeout

#Removes spawn_check_nodes which are on screen (invalid spawn locations)
# and adds spawn_check_nodes that have left the screen (valid spawn locations)
func _on_visible_on_screen_notifier_2d_state_changed(on_screen_node, is_on_screen):
	if(is_on_screen):
		valid_spawn_locations.remove_at(valid_spawn_locations.find(on_screen_node))
		print(valid_spawn_locations.size())
	else:
		valid_spawn_locations.append(on_screen_node)
		print(valid_spawn_locations.size())

func clear_spawn_list():
	enemy_spawn_list.clear()
	
func add_enemy(enemy):
	enemy_spawn_list.append(enemy)
