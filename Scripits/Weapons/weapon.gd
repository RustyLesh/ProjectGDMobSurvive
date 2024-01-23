extends Node
class_name Weapon
#Base class for player weapon

@onready var weapon_manager: WeaponManager = get_parent()
@onready var stat_container: StatContainer = weapon_manager.stat_container
@export var fire_rate = 2.0 : set = set_fire_rate 
@export var bullet_scene = preload("res://Objects/bullet.tscn")
@export var on_hit_effects: Array[OnHitEffect]
@export var base_stat_mods: Array[BaseStat]

var delay

func init_weapon(_base_stat_mods: Array[BaseStat]):
	pass

func set_fire_rate(value : float):
	fire_rate = value
	delay = 1/fire_rate