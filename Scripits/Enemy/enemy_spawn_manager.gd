extends Node2D

#@onready var spawner = $EnemySpawner
@onready var player = get_tree().get_first_node_in_group("player")
@export var spawns: Array[spawn_data] = []
@onready var base_spawn_animation = preload("res://Objects/enemy_spawn_animations/enemy_spawn_animation_node.tscn")
var topLeft : Vector2
var botRight : Vector2 

@onready var timer: Timer = $Timer
signal on_spawn_timer_pause()
signal on_spawn_timer_play()

@export var wallSpawnBuffer = 0.0
@onready var container = $Container
@export var time = 0
func _ready():
	var tilemap = get_tree().get_first_node_in_group("Level").get_node("Tile_Map")
	
	if tilemap is TileMap:
		topLeft = tilemap.map_to_local(Vector2(0,0))
		var botRightArray :Array[Vector2i] = tilemap.get_used_cells(1)
		botRight = tilemap.map_to_local(botRightArray[botRightArray.size() - 1])
		topLeft.x += wallSpawnBuffer
		topLeft.y += wallSpawnBuffer
		
		botRight.x -= wallSpawnBuffer
		botRight.y -= wallSpawnBuffer
		
		botRight *= -1

func pause_timer():
	timer.paused = true
	on_spawn_timer_pause.emit()

func play_timer():
	timer.paused = false
	on_spawn_timer_play.emit()

func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawns
	for i in enemy_spawns:
		spawn(i)

func spawn(spawn_data):
	var spawn_animation = base_spawn_animation.instantiate()
	
	if time >= spawn_data.time_start && time <= spawn_data.time_end:
		if spawn_data.spawn_delay_counter < spawn_data.spawn_delay:
			spawn_data.spawn_delay_counter += 1
		else:
			spawn_data.spawn_delay_counter
			var new_enemy = load(str(spawn_data.enemy.resource_path))
			var counter = 0
			while counter < spawn_data.enemy_amount:
				var spawnPos = get_random_position()
				container.add_child(spawn_animation)
				spawn_animation.sprite_frames = spawn_data.spawn_animation
				spawn_animation.global_position = spawnPos
				spawn_animation.play()
				
				await get_tree().create_timer(3).timeout
				spawn_animation.queue_free()
				
				var enemy_spawn = new_enemy.instantiate()
				enemy_spawn.get_node("Body").global_position = spawnPos
				add_child(enemy_spawn)
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

func get_random_position():
	var pos : Vector2 = Vector2.ZERO
	pos.x = randf_range(topLeft.x, botRight.x)
	pos.y = randf_range(topLeft.y, botRight.y)
	return pos
