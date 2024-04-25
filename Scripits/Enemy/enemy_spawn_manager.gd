class_name EnemySpawnManager extends Node2D
## Manages enemy spawning from spawn data resources

@export var enemy_spawns: EnemySpawns

@onready var player = get_tree().get_first_node_in_group("Player").get_node("PlayerBody")
@onready var tilemap = $"../Tile_Map"
@onready var enemy_container = $"Enemy Container"
@onready var ui_scene = $"../UI" as MenuManager
@onready var upgrade_manager = $"../Upgrade Manager"

#Keeps track of time for spawning enemies
@onready var timer: Timer = $Timer
signal on_spawn_timer_pause()
signal on_spawn_timer_play()
var game_win_time

var spawns: Array[SpawnDataResource]
var topLeft : Vector2
var botRight : Vector2 
var center: Vector2 

@export var wallSpawnBuffer = 0.0
@export var time = 0

@export var disable_spawns: bool

signal stage_win()

func _ready():
	#Creates points for each corner of the tilemap for spawning algorithm
	if tilemap is TileMap:
		topLeft = tilemap.map_to_local(Vector2(0,0))
		var botRightArray :Array[Vector2i] = tilemap.get_used_cells(0)
		botRight = tilemap.map_to_local(botRightArray[botRightArray.size() - 1])
		center.x = botRight.x
		center.y = botRight.y
		botRight.x *= 2
		botRight.y *= 2

		topLeft.x += wallSpawnBuffer
		topLeft.y += wallSpawnBuffer
		
		botRight.x -= wallSpawnBuffer
		botRight.y -= wallSpawnBuffer

		if disable_spawns == true:
			pause_timer()
		
		enemy_spawns = PlayerSetup.enemy_spawns
		spawns = enemy_spawns.spawns
	
	game_win_time = spawns[spawns.size() - 1].time_end + 5

#Pause spawn timer
func pause_timer():
	timer.paused = true
	on_spawn_timer_pause.emit()

#Resume spawn timer
func play_timer():
	timer.paused = false
	on_spawn_timer_play.emit()

#Adds time to spawn timer
func _on_timer_timeout():
	time += 1
	ui_scene.stage_timer.update_timer(time)
	ui_scene.seconds_timer.update_timer(time)
	for i in spawns:
		spawn(i)
	if time >= game_win_time:
		on_stage_win()
		if	enemy_spawns.stage_number > PlayerStats.highest_stage_completed:
			PlayerStats.highest_stage_completed = enemy_spawns.stage_number

func spawn(spawn_data: SpawnDataResource):
	if spawn_data is SpawnDataResource:
		#When timer reaches start spawn time
		if time >= spawn_data.time_start && time <= spawn_data.time_end: 
			#If spawning boss
			if spawn_data.enemy_resource.enemy_type == spawn_data.enemy_resource.EnemyType.BOSS:
				#if the boss has already spawned, skip
				if spawn_data.has_spawned:
					return
				spawn_boss(spawn_data.enemy_resource)
				var enemy_spawn = spawn_data.get_enemy_instance(spawn_data.enemy_resource, center, enemy_container)
				enemy_spawn.on_boss_death.connect(ui_scene.on_boss_death)
				enemy_spawn.on_boss_death.connect(on_boss_death)
				enemy_spawn.on_current_hp_changed.connect(ui_scene.on_boss_current_health_changed)
				pause_timer()
			else:

				#Check if spawn delay is passed, if not add time to delay counter
				if spawn_data.spawn_delay_counter < spawn_data.spawn_delay:
					spawn_data.spawn_delay_counter += 1
				else:
					spawn_data.spawn_delay_counter = 0
					var counter = 0
					while counter < spawn_data.enemy_amount:
						var enemy_spawn = spawn_data.get_enemy_instance(spawn_data.enemy_resource, get_random_position(), enemy_container)
						#If elite connect elite on death
						if spawn_data.enemy_resource.enemy_type == spawn_data.enemy_resource.EnemyType.ELITE:
							enemy_spawn.on_elite_dead.connect(on_elite_killed)
						counter += 1
			
func get_random_position_off_screen():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var player_pos = player.global_position
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

func spawn_boss(enemy_resource: EnemyResource):
	ui_scene.on_boss_spawn(enemy_resource.enemy_shell_resource.hp_bar_texture_resource)

func on_boss_death():
	play_timer()

func on_stage_win():
	if enemy_spawns.stage_number < PlayerStats.highest_stage_completed:
		PlayerStats.highest_stage_completed = enemy_spawns.stage_number
	stage_win.emit()

func on_elite_killed():
	upgrade_manager.add_reroll_points(1)
