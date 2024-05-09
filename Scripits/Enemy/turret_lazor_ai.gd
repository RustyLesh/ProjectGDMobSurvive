class_name AITurretLazor extends CharacterBody2D

@onready var player: Node2D = get_tree().get_first_node_in_group(("Player")).get_node("Body")
@onready var nav_agent := %NavAgent as NavigationAgent2D 
@onready var enemy_shell := $".." as EnemyShell
@onready var lazor_animation_player: AnimationPlayer = %LazorAnimiationPlayer
@onready var lazor: ShapeCastLazor = %Lazor

var follow_range: int

var follows_player:= true
var speed: float = 100.0
var delay_betweeen_shots: float = 1.5
var shoot_duration: float

var is_player_in_range:= false
var is_shooting = false
var distance_from_player

func _ready():
	await get_tree().create_timer(.001).timeout
	make_path()

func init_ai(resource: TurretLazorResource):
	speed = resource.move_speed
	delay_betweeen_shots = resource.delay_betweeen_shots
	follow_range = resource.follow_range
	shoot_duration = resource.shoot_duration

func _physics_process(_delta: float):
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	#Checks if colliding with player during movement and applies contact damage
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider().get_parent()
		if collision is Player:
			collision.take_damage(enemy_shell.deal_damage())

	if is_player_in_range:
		lazor.look_at(player.position)
		lazor.rotate(PI/2)

#creates path from movement resource attached to enemy node
func make_path():
	distance_from_player = global_position.distance_to(player.global_position)
	if is_shooting:
		return

	#If player is not in range, keep moving to player
	if !is_player_in_range:
		nav_agent.target_position = player.global_position

	
	if distance_from_player <= follow_range && !is_player_in_range:
		is_player_in_range = true
		nav_agent.target_position = global_position
		shoot()

	if distance_from_player > follow_range && is_player_in_range:
		is_player_in_range = false

func _on_timer_timeout():
	make_path()

func shoot():
	lazor_animation_player.play("fire lazor")
