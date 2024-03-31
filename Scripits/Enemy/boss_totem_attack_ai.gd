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
var alternate_counter = 0
@export var boss_diff = 2

func _ready():
	boss_diff = PlayerSetup.difficulty
	bullet_scene = bullet_resource.get_bullet_scene()

	timer_phase_1.one_shot = true
	timer_phase_2.one_shot = true

	timer_phase_1.timeout.connect(on_phase_1_finish)
	timer_phase_2.timeout.connect(on_phase_2_finish)
	switch_phase(Phase.PHASE_1)

#Odd proj_per_shot count only
func shoot_at_player(shots_per_burst: int, delay: float, proj_per_shot, angle_betweeb_proj):
	var shots_from_center = (proj_per_shot - 1) / 2
	var start_angle = angle_betweeb_proj*shots_from_center

	print("boss shooting at player")
	for burst_index in shots_per_burst:
		for proj_index in proj_per_shot:
			var bullet = bullet_scene.instantiate()
			add_child(bullet)
			bullet.global_position = global_position
			bullet.lifetime = 5
			bullet.look_at(player.global_position)
			bullet.rotate(PI/2)
			bullet.rotate(deg_to_rad(start_angle - (angle_betweeb_proj * proj_index)))
		
		await get_tree().create_timer(delay).timeout

#Shots bullets in a radial patern from source. angle_degrees is angle between each shot.
func bullet_nova(no_of_shots, alternates_angle: bool):
	var angles = 360 / no_of_shots
	print("boss shooting nova")
	for i in no_of_shots:
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.global_position = global_position
		bullet.lifetime = 10
		if alternates_angle:
			if (alternate_counter % 2 == 1):
				bullet.rotate(deg_to_rad((angles * i) + (angles / 2)))
				print("If hit: ", alternate_counter)
			else:
				bullet.rotate(deg_to_rad(angles * i))
				print("Else hit: ", alternate_counter)
		else:
			bullet.rotate(deg_to_rad(angles * i))

	alternate_counter += 1

func on_phase_1_finish():
	print("phase 1 finish")
	alternate_counter = 0
	switch_phase(Phase.PHASE_2)

func on_phase_2_finish():
	print("phase 1 finish")
	switch_phase(Phase.PHASE_1)

func on_phase_1_attack():
	print("phase1 shoot")
	bullet_nova(4 * boss_diff, true)

func on_phase_2_attack():
	print("phase2 shoot")
	shoot_at_player(1 * boss_diff, 0.5, 3, 45)

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