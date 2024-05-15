class_name KnightAi extends CharacterBody2D

@onready var player: Node2D = get_tree().get_first_node_in_group(("Player")).get_node("Body")
@onready var nav_agent := %NavAgent as NavigationAgent2D 
@onready var enemy_shell := $".." as EnemyShell
@onready var timer = $MovementTimer
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var attack_timer: Timer = %AttackTimer
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


#creates path from movement resource attached to enemy node
func make_path():
	if !enabled:
		return

	distance_from_player = global_position.distance_to(player.global_position)

	if distance_from_player <= follow_range && !is_player_in_range:
		is_player_in_range = true
		nav_agent.target_position = global_position
		animation_player.play("attack")
		state = AI_State.ATTACKING

	elif distance_from_player > follow_range + 10 && is_player_in_range:
		await animation_player.animation_finished
		is_player_in_range = false
		state = AI_State.MOVING

	if !is_player_in_range:
		nav_agent.target_position = player.global_position
	
func _on_timer_timeout():
	make_path()
	pass

func shoot():
	enemy_shell.shoot(player.global_position)

func start():
	print("Range: ", follow_range)
	enabled = true
	timer.start()

func attack():
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
			pass
		AI_State.ATTACKING:
			pass

func look_at_player():
		attack_nodes.look_at(player.position)
		attack_nodes.rotate(PI/LOOK_VALUE)

func start_attack_timer():
	attack_timer.start(delay_betweeen_shots)

func _on_attack_area_body_entered(body:Node2D):
	print("hit attack")
	var collided = body.get_parent()
	if collided is Player:
		collided.take_damage(enemy_shell.deal_damage())

func attack_toggle(value: bool):
	attack_area_check.monitoring = value
