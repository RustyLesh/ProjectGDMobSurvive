class_name AITurretLazor extends CharacterBody2D

@onready var player: Node2D = get_tree().get_first_node_in_group(("Player")).get_node("Body")
@onready var nav_agent := %NavAgent as NavigationAgent2D 
@onready var enemy_shell := $".." as EnemyShell
@onready var lazor_animation_player: AnimationPlayer = %LazorAnimiationPlayer
@onready var lazor: ShapeCastLazor = %Lazor
@onready var path_timer: Timer = $"MovementTimer"
@onready var shoot_timer: Timer = %ShootTimer

var follow_range: int

var follows_player:= true
var speed: float = 100.0

var is_player_in_range:= false
var distance_from_player

var enabled:= false

var state: EnemyState
var is_charging = false #Charging phase in firing lazor

enum EnemyState{
	MOVING,
	SHOOTING,
}

func init_ai(resource: TurretLazorResource):
	state = EnemyState.MOVING
	speed = resource.move_speed
	follow_range = resource.follow_range

func _physics_process(_delta: float):
	if !enabled:
		return 

	distance_from_player = global_position.distance_to(player.global_position)

	#Check if player is in range
	if distance_from_player <= follow_range && !is_player_in_range:
		is_player_in_range = true
		if state != EnemyState.SHOOTING:
			lazor_animation_player.play("fire lazor")
			change_state(EnemyState.SHOOTING)

	#If player is out of range
	elif is_player_in_range:
		is_player_in_range = false
		if state != EnemyState.MOVING:
			change_state(EnemyState.MOVING)

	#Check state
	match state:
		EnemyState.MOVING:
			if(nav_agent.distance_to_target() < 5):
				return
			var dir = to_local(nav_agent.get_next_path_position()).normalized()
			velocity = dir * speed
			move_and_slide()
			#Checks if colliding with player during movement and applies contact damage
			for i in get_slide_collision_count():
				var collision = get_slide_collision(i).get_collider().get_parent()
				if collision is Player:
					collision.take_damage(enemy_shell.deal_damage())
		EnemyState.SHOOTING:
			if is_charging:
				lazor.look_at(player.position)
				lazor.rotate(PI/2)

#Create navigation path
func make_path():
	if !enabled:
		return

	#If player is not in range, keep moving to player
	if !is_player_in_range:
		if lazor_animation_player.is_playing():
			await lazor_animation_player.animation_finished
			nav_agent.target_position = player.global_position
	else:
		nav_agent.target_position = global_position

func _on_timer_timeout():
	make_path()

func start():
	path_timer.start()
	print("enabled")
	enabled = true

func change_state(new_state: EnemyState):
	match state:
		EnemyState.SHOOTING:
			lazor_animation_player.get_animation("fire lazor").loop_mode = Animation.LOOP_NONE

	state = new_state
	match state:
		EnemyState.SHOOTING:
			lazor_animation_player.get_animation("fire lazor").loop_mode = Animation.LOOP_LINEAR

func toggle_charging(value: bool):
	is_charging = value
