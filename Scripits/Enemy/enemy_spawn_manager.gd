extends Node2D

@onready var spawner = $EnemySpawner
@onready var player = get_tree().get_first_node_in_group("player")
@export var spawns: Array[spawn_data] = []
@onready var base_spawn_animation = preload("res://Objects/enemy_spawn_animations/enemy_spawn_animation_node.tscn")
var topLeft : Vector2
var botRight : Vector2 

@export var wallSpawnBuffer = 0.0
@onready var container = $Container
var time = 0
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
		
		print(topLeft)
		print(botRight)
		print(botRightArray.size())

func _on_timer_timeout():
	time += 1
	print(time)
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if time >= i.time_start && time <= i.time_end:
			if i.spawn_delay_counter < i.spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter
				var new_enemy = load(str(i.enemy.resource_path))
				var counter = 0
				while counter < i.enemy_amount:
					var spawnPos = get_random_position()
#					if base_spawn_animation is AnimatedSprite2D:
					var spawn_animation = base_spawn_animation.instantiate()
						
					container.add_child(spawn_animation)
					spawn_animation.sprite_frames = i.spawn_animation
					spawn_animation.global_position = spawnPos
					spawn_animation.play()
					
					
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.get_node("Body").global_position = spawnPos
					add_child(enemy_spawn)
					counter += 1

func spawn():
	pass

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
