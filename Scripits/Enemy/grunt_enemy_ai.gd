class_name GruntAI extends CharacterBody2D
## Moves the enemies body based on the movement resource attached to the given enemy node.

var speed: float = 100.0

@onready var player: Node2D = get_tree().get_first_node_in_group(("Player")).get_node("Body")
@onready var nav_agent := $NavAgent as NavigationAgent2D 
@onready var enemy_shell := $".." as EnemyShell
@onready var path_timer: Timer = $"MovementTimer"

@export var attack_pause_time: int = 1

var enabled:= false

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
			path_timer.paused = true
			await get_tree().create_timer(attack_pause_time).timeout
			path_timer.paused = false
			return

#creates path from movement resource attached to enemy node
func make_path():
	nav_agent.target_position = player.position
	
func _on_timer_timeout():
	print("path")
	make_path()

func start():
	path_timer.start()
	enabled = true
