extends Node
class_name Weapon
var bullet_scene = preload("res://Objects/bullet.tscn")
#shots per second
@export var fire_rate = 2.0 : set = set_fire_rate 

var delay
@onready var bullet_container = $BulletContainer

func _ready():
	set_fire_rate(fire_rate)
	shoot()
	
func shoot():
	while true:
		await get_tree().create_timer(delay).timeout
		var bullet_instance = bullet_scene.instantiate()
		bullet_container.add_child(bullet_instance)
		bullet_instance.global_position = get_parent().get_node("PlayerBody").global_position
		bullet_instance.rotate(get_parent().get_node("PlayerBody").rotation)

func set_fire_rate(value : float):
	print("value", value)
	fire_rate = value
	delay = 1/fire_rate
