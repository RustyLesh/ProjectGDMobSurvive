extends Node

var bullet_scene = preload("res://Objects/bullet.tscn")

@export var fire_rate := 2.0 # seconds
var delay := 0.0

@onready var bullet_container = $BulletContainer

func _ready():
	delay = 1/fire_rate
	print(delay)
	print(fire_rate)
	shoot()

func _process(delta):
	if(Input.is_action_just_pressed("action_1")):
		shoot()
	
func shoot():
	while true:
		await get_tree().create_timer(delay).timeout
		var bullet_instance = bullet_scene.instantiate()
		bullet_container.add_child(bullet_instance)
		bullet_instance.global_position = get_parent().global_position
		bullet_instance.rotate(get_parent().rotation)
