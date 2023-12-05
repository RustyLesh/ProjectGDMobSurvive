extends Node
class_name StatContainer

var base_stats: Array[BaseStat]

#Base stats
@export var max_life = 100
@export var damage = 100
@export var fire_rate = 2
@export var movement_speed = 100

var health : Health
var player_body : PlayerController
var weapon_manager : WeaponManager

func get_stat(base_stat_type : BaseStat.BaseStatType) -> BaseStat:
	return base_stats[base_stat_type]

func init_stats():
	var life_mod := StatMod.new()
	life_mod.value = max_life
	life_mod.stat_mod_type = StatMod.StatModType.FLAT
	
	var damage_mod := StatMod.new()
	damage_mod.value = damage
	damage_mod.stat_mod_type = StatMod.StatModType.FLAT	
	
	var fire_rate_mod := StatMod.new()
	fire_rate_mod.value = fire_rate
	fire_rate_mod.stat_mod_type = StatMod.StatModType.FLAT	
	
	var movement_speed_mod := StatMod.new()
	movement_speed_mod.value = movement_speed
	movement_speed_mod.stat_mod_type = StatMod.StatModType.FLAT	
	
	if health is Health:
		health.init_health(max_life)
		
	base_stats[BaseStat.BaseStatType.MAX_LIFE].apply_stat(life_mod)
	base_stats[BaseStat.BaseStatType.DAMAGE].apply_stat(damage_mod)
	base_stats[BaseStat.BaseStatType.FIRE_RATE].apply_stat(fire_rate_mod)
	base_stats[BaseStat.BaseStatType.MOVEMENT_SPEED].apply_stat(movement_speed_mod)

func add_mod_to_base_stat(stat_mod : StatMod, stat_type : BaseStat.BaseStatType):
	base_stats[stat_type].apply_stat(stat_mod)

func remove_mod_from_base_stat(stat_type : BaseStat.BaseStatType, source: Resource):
	base_stats[stat_type].remove_stat(source)
	
func update_max_life(value: int):
	health.set_max_health(value)

func update_fire_rate(value: float):
	weapon_manager.fire_rate = value

func update_movement_speed(value: float):
	player_body.speed = value

func update_extra_prop_count(value: int):
	weapon_manager.extra_proj_count = value

func update_bullet_lifetime(value: float):
	weapon_manager.bullet_lifetime = value

func update_pierce(value: float):
	weapon_manager.pierce = value

func init_stat_signals():
	base_stats[BaseStat.BaseStatType.MAX_LIFE].on_value_changed.connect(update_max_life)
	base_stats[BaseStat.BaseStatType.MOVEMENT_SPEED].on_value_changed.connect(update_movement_speed)
	base_stats[BaseStat.BaseStatType.FIRE_RATE].on_value_changed.connect(update_fire_rate)
	base_stats[BaseStat.BaseStatType.PROJ_COUNT].on_value_changed.connect(update_extra_prop_count)
	base_stats[BaseStat.BaseStatType.BULLET_LIFE_TIME].on_value_changed.connect(update_bullet_lifetime)
	base_stats[BaseStat.BaseStatType.PIERCE].on_value_changed.connect(update_pierce)
