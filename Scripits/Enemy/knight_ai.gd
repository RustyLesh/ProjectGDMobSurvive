class_name KnightAi extends CharacterBody2D

@onready var player: Node2D = get_tree().get_first_node_in_group(("Player")).get_node("Body")
@onready var nav_agent := %NavAgent as NavigationAgent2D 
@onready var enemy_shell := $".." as EnemyShell
@onready var timer = $MovementTimer
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var attack_area_check: Area2D = %AttackArea
@onready var attack_nodes: Node2D = % AttackNodes
@export var follow_range: int

var follows_player:= false
var speed: float = 100.0
var delay_betweeen_shots: float = 1

var enabled := false
var distance_from_player
var is_player_in_range:= false
var is_attacking:= false
var state: AI_State = AI_State.MOVING
const LOOK_VALUE = 4

enum AI_State{
	MOVING,
	ATTACKING,
}

func _physics_process(_delta: float):
	if !enabled:
		return
	
	if state == AI_State.MOVING:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed
		move_and_slide()
		#Checks if colliding with player during movement and applies contact damage
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i).get_collider().get_parent()
			if collision is Player:
				collision.take_damage(enemy_shell.deal_damage())
	
	#if state == AI_State.ATTACKING:


# Creates path from movement resource attached to enemy node
# Also controls state machine
func make_path():
	if !enabled:
		return

	distance_from_player = global_position.distance_to(player.global_position)

	# If player is in range, change to attack
	if distance_from_player <= follow_range && !is_player_in_range && state != AI_State.ATTACKING:  
		change_state(AI_State.ATTACKING)

	# If player is not in range, change to move
	elif distance_from_player > follow_range + 10 && is_player_in_range && state != AI_State.MOVING:
		change_state(AI_State.MOVING)

	if state == AI_State.MOVING && !animation_player.is_playing():
		nav_agent.target_position = player.global_position # Move to player

	if state == AI_State.ATTACKING && !animation_player.is_playing():
		attack()

func _on_timer_timeout():
	make_path()

func shoot():
	enemy_shell.shoot(player.global_position)

func start():
	enabled = true
	timer.start()

# Stop moving and play attack animations
func attack():
	nav_agent.target_position = global_position
	animation_player.play("attack")

func change_state(new_state: AI_State):
	match state:
		AI_State.MOVING:
			pass
		AI_State.ATTACKING:
			pass
	
	state = new_state

	match state:
		AI_State.MOVING:
			print("moving")
			is_player_in_range = false
		AI_State.ATTACKING:
			print("attacking")
			nav_agent.target_position = global_position # Set nav target to current position
			is_player_in_range = true

func look_at_player():
		attack_nodes.look_at(player.position)
		attack_nodes.rotate(PI/LOOK_VALUE)

func _on_attack_area_body_entered(body:Node2D):
	var collided = body.get_parent()
	if collided is Player:
		collided.take_damage(enemy_shell.deal_damage())

func attack_toggle(value: bool):
	attack_area_check.monitoring = value