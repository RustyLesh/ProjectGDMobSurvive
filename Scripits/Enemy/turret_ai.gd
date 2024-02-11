extends CharacterBody2D
class_name AITurret

@onready var player: Node2D = get_tree().get_first_node_in_group(("Player")).get_node("PlayerBody")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D 
@onready var enemy_shell := $".." as EnemyShell
@onready var timer = $"Shoot Timer"

@export var follow_range: int
var follows_player:= false
var is_player_in_range:= false
var speed: float = 100.0
var delay_betweeen_shots: float = 1.0

func _ready():
	await get_tree().create_timer(.001).timeout
	make_path()

func _physics_process(_delta: float):
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	#Checks if colliding with player during movement and applies contact damage
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider().get_parent()
		if collision is Player:
			collision.take_damage(enemy_shell.deal_damage())

#creates path from movement resource attached to enemy node
func make_path():
	if !is_player_in_range:
		nav_agent.target_position = player.global_position
	
	if nav_agent.distance_to_target() <= follow_range && !is_player_in_range:
		is_player_in_range = true
		nav_agent.target_position = global_position
		start_shooting()
	
func _on_timer_timeout():
	make_path()

func start_shooting():
	timer.start(delay_betweeen_shots)

func shoot():
	enemy_shell.shoot(player.global_position)
