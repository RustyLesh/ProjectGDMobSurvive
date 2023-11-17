extends Node
class_name WeaponManager
var bullet_scene = preload("res://Objects/bullet.tscn")

#Shots per second
#Global weapon stats
@export var fire_rate = 2.0 : set = set_fire_rate 
@export var extra_proj_count: int = 0;
@export var shot_angle_variation = 15
@export var bullet_lifetime: float = 1.0
@export var weapons: Array[Weapon]
var delay
@onready var bullet_container = $"Bullet Container"
@onready var player_body = $"../PlayerBody"

func _ready():
	set_fire_rate(fire_rate)
	
func set_fire_rate(value : float):
	fire_rate = value
	delay = 1/fire_rate
