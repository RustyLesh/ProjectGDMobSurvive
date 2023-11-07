extends Node
class_name Weapon
var bullet_scene = preload("res://Objects/bullet.tscn")

#Shots per second
@export var fire_rate = 2.0 : set = set_fire_rate 
@export var extra_proj_count: int = 0;
@export var shot_angle_variation = 15
@export var bullet_lifetime: float = 1.0

var delay
@onready var bullet_container = $BulletContainer

func _ready():
	set_fire_rate(fire_rate)
	shoot()
	
func shoot():
	while true:
		await get_tree().create_timer(delay).timeout
		for i in 1 + extra_proj_count:
			var bullet_instance = bullet_scene.instantiate()
			if bullet_instance is Bullet:
				bullet_instance.lifetime = bullet_lifetime
			bullet_container.add_child(bullet_instance)
			bullet_instance.global_position = get_parent().get_node("PlayerBody").global_position
			var shot_angle = deg_to_rad( randi_range(-shot_angle_variation/2 ,shot_angle_variation / 2))
			bullet_instance.rotate(get_parent().get_node("PlayerBody").rotation + shot_angle)

func set_fire_rate(value : float):
	fire_rate = value
	delay = 1/fire_rate
