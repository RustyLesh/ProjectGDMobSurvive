extends Node2D
class_name EnemySpawnManager

#Manages enemy spawning from spawn data resources

@onready var player = get_tree().get_first_node_in_group("Player").get_node("PlayerBody")
@export var spawns: Array[SpawnDataResource]
var topLeft : Vector2
var botRight : Vector2 

@onready var tilemap = $"../Tile_Map"

#Keeps track of time for spawning enemies
@onready var timer: Timer = $Timer
signal on_spawn_timer_pause()
signal on_spawn_timer_play()

@export var wallSpawnBuffer = 0.0
@export var time = 0

func _ready():
	#Creates points for each corner of the tilemap for spawning algorithm
	if tilemap is TileMap:
		topLeft = tilemap.map_to_local(Vector2(0,0))
		var botRightArray :Array[Vector2i] = tilemap.get_used_cells(0)
		botRight = tilemap.map_to_local(botRightArray[botRightArray.size() - 1])
		print(botRight)

		topLeft.x += wallSpawnBuffer
		topLeft.y += wallSpawnBuffer
		
		botRight.x -= wallSpawnBuffer
		botRight.y -= wallSpawnBuffer
		
		print(topLeft)

#Pause spawn timer
func pause_timer():
	timer.paused = true
	print("paused timer")
	on_spawn_timer_pause.emit()

#Resume spawn timer
func play_timer():
	timer.paused = false
	on_spawn_timer_play.emit()

#Adds time to spawn timer
func _on_timer_timeout():
	time += 1
	for i in spawns:
		spawn(i)

func spawn(spawn_data: SpawnDataResource):
	if spawn_data is SpawnDataResource:
		if time >= spawn_data.time_start && time <= spawn_data.time_end:
			if spawn_data.spawn_delay_counter < spawn_data.spawn_delay:
				spawn_data.spawn_delay_counter += 1
			else:
				spawn_data.spawn_delay_counter = 0
				var new_enemy = load(str(spawn_data.enemy_resource.enemy_base_object.resource_path))
				var counter = 0
				while counter < spawn_data.enemy_amount:
					var enemy_spawn: EnemyNode = new_enemy.instantiate()
					add_child(enemy_spawn)
					enemy_spawn.init_enemy(spawn_data.enemy_resource)
					enemy_spawn.character_body.global_position = get_random_position()
					counter += 1

func get_random_position_off_screen():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var player_pos = player.get_node("PlayerBody").global_position
	var top_left = Vector2(player_pos.x - vpr.x/2, player_pos.y - vpr.y/2)
	var top_right = Vector2(player_pos.x + vpr.x/2, player_pos.y - vpr.y/2)
	var bottom_left= Vector2(player_pos.x - vpr.x/2, player_pos.y + vpr.y/2)
	var bottom_right = Vector2(player_pos.x + vpr.x/2, player_pos.y + vpr.y/2)
	var pos_side = ["up", "down", "left", "right"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up": 
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down": 
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"left": 
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
		"right": 
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
			
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)

func get_random_position() -> Vector2:
	var pos : Vector2 = Vector2.ZERO
	pos.x = randf_range(topLeft.x, botRight.x)
	pos.y = randf_range(topLeft.y, botRight.y)
	return pos
