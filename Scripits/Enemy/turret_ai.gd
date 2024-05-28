class_name AITurret extends CharacterBody2D

@onready var player: Node2D = get_tree().get_first_node_in_group(("Player")).get_node("Body")
@onready var nav_agent := %NavAgent as NavigationAgent2D 
@onready var enemy_shell := $".." as EnemyShell
@onready var timer = $MovementTimer
@onready var shoot_timer = $"ShootTimer"

@export var follow_range: int
var follows_player:= false
var is_player_in_range:= false
var speed: float = 100.0
var delay_betweeen_shots: float = 1.5
var distance_from_player
var enabled := false



func _physics_process(_delta: float):
	if !enabled:
		return
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
	if !enabled:
		return

	distance_from_player = global_position.distance_to(player.global_position)

	if distance_from_player <= follow_range && !is_player_in_range:
		print("In range")
		is_player_in_range = true
		nav_agent.target_position = global_position
		start_shooting()
	elif distance_from_player > follow_range + 10 && is_player_in_range:
		print("Out of range")
		is_player_in_range = false
		shoot_timer.stop()

	if !is_player_in_range:
		nav_agent.target_position = player.global_position
	
func _on_timer_timeout():
	make_path()

func start_shooting():
	shoot_timer.start(delay_betweeen_shots)

func shoot():
	enemy_shell.shoot(player.global_position)

func start():
	enabled = true
	timer.start()
	shoot_timer.start()
