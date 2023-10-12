extends Node
@export var valid_spawn_locations: Array[VisibleOnScreenNotifier2D]

@onready var enemy_container = $EnemyContainer

@export var enemy_scene = preload("res://Objects/basic_enemy_1.tscn")
@export var spawn_rate := 10.0 # amount per second
@export var number_to_spawn = 1
var delay := 0.0

var spawning_enabled = true

func _ready():
	for notifier_node in get_children():
		valid_spawn_locations.append(notifier_node)
	delay = 1 / spawn_rate
	spawn()

func _process(delta):
	if(Input.is_action_just_pressed("action_1")):
		spawn()

func spawn():
	while true:
		if(valid_spawn_locations.size() > 0 && spawning_enabled):
			var enemy_instance = enemy_scene.instantiate()
			enemy_container.add_child(enemy_instance)
			enemy_instance.global_position = valid_spawn_locations.pick_random().global_position
			
		await get_tree().create_timer(delay).timeout

func _on_visible_on_screen_notifier_2d_state_changed(on_screen_node, is_on_screen):
	if(is_on_screen):
		valid_spawn_locations.remove_at(valid_spawn_locations.find(on_screen_node))
		print("on screen")
		print(valid_spawn_locations.size())
	else:
		valid_spawn_locations.append(on_screen_node)
		print("off screen")
		print(valid_spawn_locations.size())
