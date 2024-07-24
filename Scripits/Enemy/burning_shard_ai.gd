class_name BurningShardAi extends CharacterBody2D
## Moves the enemies body based on the movement resource attached to the given enemy node.

var speed: float = 100.0

@onready var player: Node2D = get_tree().get_first_node_in_group(("Player")).get_node("Body")
@onready var nav_agent := $NavAgent as NavigationAgent2D 
@onready var enemy_shell := $".." as EnemyShell

@export var attack_pause_time: int = 1
var reached_target = false

func _physics_process(_delta: float):
	if nav_agent.distance_to_target() > 2:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed
		move_and_slide()

func start():
	nav_agent.target_position = player.position

func _on_area_2d_body_entered(body:Node2D):
	var collided = body.get_parent()
	if collided is Player:
		collided.take_damage(enemy_shell.contact_damage)	
