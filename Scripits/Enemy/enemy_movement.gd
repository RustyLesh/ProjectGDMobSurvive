extends CharacterBody2D
class_name EnemyMovement
var speed: float = 100.0

@onready var player: Node2D = get_tree().get_first_node_in_group(("player")).get_node("PlayerBody")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D 
@onready var enemy_node := $".." as Enemy
func _ready():
	make_path()

func _physics_process(delta: float):
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider().get_parent()
		if collision is Player:
			collision.take_damage(enemy_node.deal_damage())
			

func make_path():
	nav_agent.target_position = player.global_position
	
func _on_timer_timeout():
	make_path()
