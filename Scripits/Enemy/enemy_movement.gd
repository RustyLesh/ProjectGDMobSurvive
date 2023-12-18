extends CharacterBody2D
class_name EnemyMovement
#Moves the enemies body based on the movement resource attached to the given enemy node.

var speed: float = 100.0

@onready var player: Node2D = get_tree().get_first_node_in_group(("Player")).get_node("PlayerBody")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D 
@onready var enemy_node := $".." as EnemyNode

func _ready():
	await get_tree().create_timer(.001).timeout
	make_path()

func _physics_process(delta: float):
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	#Checks if colliding with player during movement and applies contact damage
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider().get_parent()
		if collision is Player:
			collision.take_damage(enemy_node.deal_damage())

#creates path from movement resource attached to enemy node
func make_path():
	nav_agent.target_position = enemy_node.enemy_ai_movement.get_target_position(global_position, player.global_position)
	
func _on_timer_timeout():
	make_path()

