extends Node
class_name Weapon

@onready var weapon_manager = get_parent()
@export var fire_rate = 2.0 : set = set_fire_rate 
@export var bullet_scene = preload("res://Objects/bullet.tscn")

var delay

func init_weapon():
	pass

func set_fire_rate(value : float):
	fire_rate = value
	delay = 1/fire_rate
