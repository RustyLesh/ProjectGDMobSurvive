class_name EnemySpawnManager extends Node2D
## Manages enemy spawning from [SpawnDataResource]

@export var enemy_spawns: EnemySpawns

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var player_body = player.get_node("Body")

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

const WALL_SPAWN_BUFFER = 26.0 # Minimum distance from walls for spawning enemies (inc walls)
@export var time := 0
@export var delay_for_stage_end: int
@export var disable_spawns: bool

signal stage_win()
signal enemy_death(entity: Entity)

func _ready():
	#Creates points for each corner of the tilemap for spawning algorithm
	if tilemap is TileMap:
		topLeft = tilemap.map_to_local(Vector2(0,0))
		
		var botRightArray :Array[Vector2i] = tilemap.get_used_cells(1)
		botRight = tilemap.get_used_rect().size # Get size of tile map in no of tiles
		# Convert tiles to units
		botRight.x *= 16
		botRight.y *= 16
		center = Vector2(botRight.x / 2, botRight.y / 2) # Calculate center
		
		if disable_spawns == true:
			pause_timer()
		
		enemy_spawns = PlayerSetup.enemy_spawns
		spawns = enemy_spawns.spawns
	
	game_win_time = spawns[spawns.size() - 1].time_end + delay_for_stage_end

	enemy_death.connect(player.on_kill_effect_manager._on_entity_killed)

#Pause spawn timer
func pause_timer():
	timer.paused = true
	on_spawn_timer_pause.emit()

#Resume spawn timer
func play_timer():
	timer.paused = false
	on_spawn_timer_play.emit()

#Adds time to spawn timer, called by a timer every 1 second
func _on_timer_timeout():
	time = time + 1
	ui_scene.stage_timer.update_timer(time)
	ui_scene.seconds_timer.update_timer(time)
	for i in spawns:
		spawn(i)
	if time >= game_win_time:
		on_stage_win()
		if	enemy_spawns.stage_number > PlayerStats.highest_stage_completed:
			PlayerStats.highest_stage_completed = enemy_spawns.stage_number

func spawn(spawn_data: SpawnDataResource):
	if spawn_data.one_shot && spawn_data.has_spawned:
		return

	if time >= spawn_data.time_start && time <= spawn_data.time_end: # Wave start and end time check
		if spawn_data.spawn_delay_counter >= spawn_data.wave_delay: # Wave delay check
			# Spawn Patterns
			var enemy
			match spawn_data.spawn_pattern:
				SpawnDataResource.SpawnPattern.CLUSTER_RANDOM:
					var cluster_spawn_positions = random_cluster(spawn_data.amount, 32)
					for pos_vector in cluster_spawn_positions:
						await get_tree().process_frame
						enemy = spawn_data.spawn_enemy(pos_vector, enemy_container)
						enemy.on_death.connect(on_enemy_death)
						
				SpawnDataResource.SpawnPattern.RANDOM_SINGLE:
					enemy = spawn_data.spawn_enemy(get_random_position(0), enemy_container)
					enemy.on_death.connect(on_enemy_death)
					await get_tree().process_frame
				
				SpawnDataResource.SpawnPattern.CENTER:
					enemy = spawn_data.spawn_enemy(center, enemy_container)
					enemy.on_death.connect(on_enemy_death)
			match spawn_data.rank:
				SpawnDataResource.EnemyRank.BOSS:
					print("Boss spawning")
					spawn_boss(spawn_data)
					enemy.on_death.connect(ui_scene.on_boss_death)
					enemy.on_current_hp_changed.connect(ui_scene.on_boss_current_health_changed)
			spawn_data.spawn_delay_counter = 0

		spawn_data.spawn_delay_counter += 1

# Jank	
func get_random_position_off_screen():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var player_body_pos = player_body.global_position
	var top_left = Vector2(player_body_pos.x - vpr.x/2, player_body_pos.y - vpr.y/2)
	var top_right = Vector2(player_body_pos.x + vpr.x/2, player_body_pos.y - vpr.y/2)
	var bottom_left= Vector2(player_body_pos.x - vpr.x/2, player_body_pos.y + vpr.y/2)
	var bottom_right = Vector2(player_body_pos.x + vpr.x/2, player_body_pos.y + vpr.y/2)
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

## Gets a random position on the stage. 
## [wall_bauffer] is extra padding from wall to avoid enemies spawning inside out walls
func get_random_position(wall_buffer: int) -> Vector2:
	wall_buffer += WALL_SPAWN_BUFFER
	var pos_x = Vector2(topLeft.x + wall_buffer, topLeft.y + wall_buffer)
	var pos_y = Vector2(botRight.x - wall_buffer, botRight.y - wall_buffer)

	var pos : Vector2 = Vector2.ZERO
	pos.x = randf_range(pos_x.x, pos_y.x)
	pos.y = randf_range(pos_x.y, pos_y.y)
	return pos

func spawn_boss(enemy_spawn_data: SpawnDataResource):
	ui_scene.on_boss_spawn(enemy_spawn_data)

# Choose number of spawn, spawns the monsters in a random position in a cluster.
# The cluster size is based on area_radius.
func random_cluster(no_spawn: int, area_radius: int)-> Array[Vector2]:
	var spawn_cord_array: Array[Vector2]
	var cluster_center = get_random_position(area_radius)
	spawn_cord_array.append(cluster_center)
	var spawn_area = Vector4i(cluster_center.x - area_radius, cluster_center.y - area_radius, cluster_center.x + area_radius, cluster_center.y + area_radius) # x,y = Top left cords. z,w = Bot right cords
	for i in no_spawn:
		var spawn_pos = Vector2(randi_range(spawn_area.x, spawn_area.z), randi_range(spawn_area.y, spawn_area.w))
		spawn_cord_array.append(spawn_pos)

	return spawn_cord_array


func on_boss_death():
	play_timer()

func on_stage_win():
	if enemy_spawns.stage_number < PlayerStats.highest_stage_completed:
		PlayerStats.highest_stage_completed = enemy_spawns.stage_number
	stage_win.emit()

func on_elite_killed():
	upgrade_manager.add_reroll_points(1)

func on_enemy_death(entity: Entity):
	enemy_death.emit(entity)
