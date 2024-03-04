extends Node2D
class_name BossTotemAttackAI

enum Phase
{
	PHASE_0,
	PHASE_1,
	PHASE_2,
}


@onready var player: Node2D = get_tree().get_first_node_in_group(("Player")).get_node("PlayerBody")
@onready var attack_timer = $"AttackTimer" as Timer
@onready var timer_phase_1 = $"Phase1" as Timer
@onready var timer_phase_2 = $"Phase2" as Timer

@export var phase_1_length: int = 10
@export var phase_2_length: int = 10

@export var base_shoot_delay = 1
@export var bullet_resource: BulletResource
var bullet_scene

var current_phase = Phase.PHASE_0
var time: int = 0

func _ready():
	bullet_scene = bullet_resource.get_bullet_scene()

	timer_phase_1.one_shot = true
	timer_phase_2.one_shot = true

	timer_phase_1.timeout.connect(on_phase_1_finish)
	timer_phase_2.timeout.connect(on_phase_2_finish)
	switch_phase(Phase.PHASE_1)

func shoot_at_player(no_of_shots: int, delay: float):
	for i in no_of_shots:
		print("boss shooting")
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.global_position = global_position
		bullet.lifetime = 5
		bullet.look_at(player.global_position)
		bullet.rotate(PI/2)
		await get_tree().create_timer(delay).timeout
		

#Shots bullets in a radial patern from source. angle_degrees is angle between each shot.
func bullet_nova(no_of_shots):
	var angles = 360 / no_of_shots
	for i in no_of_shots:
		print("boss shooting")
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.global_position = global_position
		bullet.lifetime = 10
		bullet.rotate(deg_to_rad(angles * i))

func on_phase_1_finish():
	print("phase 1 finish")
	switch_phase(Phase.PHASE_2)

func on_phase_2_finish():
	print("phase 1 finish")
	switch_phase(Phase.PHASE_1)

func on_phase_1_attack():
	print("phase1 shoot")
	shoot_at_player(5, 0.1)

func on_phase_2_attack():
	print("phase2 shoot")
	bullet_nova(4)

func switch_phase(next_phase : Phase):
	print("switching from: ")
	match current_phase:	
		Phase.PHASE_0:
			print("phase0")

		Phase.PHASE_1:
			print("phase1")
			timer_phase_1.stop()
			attack_timer.timeout.disconnect(on_phase_1_attack)
			attack_timer.stop()

		Phase.PHASE_2:
			print("phase2")
			timer_phase_2.stop()
			attack_timer.timeout.disconnect(on_phase_2_attack)	
			attack_timer.stop()	
		
	current_phase = next_phase
	print("switching to: ")
	match next_phase:	
		Phase.PHASE_1:
			print("phase1")
			timer_phase_1.start(phase_1_length)
			attack_timer.timeout.connect(on_phase_1_attack)
			attack_timer.start(base_shoot_delay)

		Phase.PHASE_2:
			print("phase2")
			timer_phase_2.start(phase_2_length)		
			attack_timer.timeout.connect(on_phase_2_attack)
			attack_timer.start(base_shoot_delay)			