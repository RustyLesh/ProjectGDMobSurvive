extends CharacterBody2D

var speed: float = 100.0

@onready var player: Node2D = get_tree().get_nodes_in_group(("player"))[0].get_node("PlayerBody")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D 

func _ready():
	make_path()

func _physics_process(delta: float):
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	
func make_path():
	nav_agent.target_position = player.global_position
	
func _on_timer_timeout():
	make_path()
