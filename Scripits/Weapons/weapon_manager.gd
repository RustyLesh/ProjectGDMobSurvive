extends Node
class_name WeaponManager
var bullet_scene = preload("res://Objects/bullet.tscn")

#Shots per second
#Global weapon stats

@export var extra_proj_count: int = 0;
@export var pierce: int = 0
@export var fire_rate: float = 2.0: set = set_fire_rate 
@export var shot_angle_variation: float = 15
@export var bullet_lifetime: float = 1.0

@onready var bullet_container = $"Bullet Container"
@onready var player_body = $"../PlayerBody"
@onready var explosion_area_check: ExplosionAreaCheck = $ExplosionAreaCheck

var delay

func _ready():
	set_fire_rate(fire_rate)
	
func set_fire_rate(value : float):
	fire_rate = value
	delay = 1/fire_rate

func apply_on_hit_effect_to_weapons(effect: OnHitEffect):
	get_parent().weapon_inst.on_hit_effects.append(effect)
