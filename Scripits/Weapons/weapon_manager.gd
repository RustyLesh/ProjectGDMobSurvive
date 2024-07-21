extends Node
class_name WeaponManager
var bullet_scene = preload("res://Objects/Weapons/Player Bullets/bullet.tscn")

#Holds data for weapon stats

@export var extra_proj_count: int = 0;
@export var pierce: int = 0
@export var fire_rate: float = 2.0: set = set_fire_rate # Bullets per second
@export var spread_angle: float = 0 # Bullet spread, determines the bullets initial angle. Bullets will be spread evenly initially.
@export var spread_variation: float = 15 # Bullet accuracy, how much it can deviate from its original angle (random)
@export var bullet_lifetime: float = 1.0
@export var bullet_speed: float = 150
@export var bullet_damage: float = 1

@onready var bullet_container = $"Bullet Container"
@onready var player_body = %Body
@onready var stat_container: StatContainer = $"../Combat Stat Container"

var delay

func _ready():
	await get_tree().create_timer(.1).timeout
	set_fire_rate(fire_rate)
	
	extra_proj_count = stat_container.get_stat(BaseStat.BaseStatType.PROJ_COUNT).value
	pierce = stat_container.get_stat(BaseStat.BaseStatType.PIERCE).value
	print("Proj cnt: ", extra_proj_count)
#convert fire rate into shots per second
func set_fire_rate(value : float):
	fire_rate = value
	delay = 1/fire_rate

func apply_on_hit_effect_to_weapons(effect: OnHitEffect):
	get_parent().weapon_inst.on_hit_effects.append(effect)

