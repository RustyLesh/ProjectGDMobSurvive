extends Node
class_name StatContainer
#Initialises and holds all player base stats.
#Upgrades effect base stats through adding stat modifiers

var base_stats: Array[BaseStat]

@export_category("Base stats")
@export var max_life = 100
@export var damage = 100
@export var fire_rate = 2
@export var movement_speed = 100

var health : Health
var player_body : PlayerController
var weapon_manager : WeaponManager

func get_stat(base_stat_type : BaseStat.BaseStatType) -> BaseStat:
	return base_stats[base_stat_type]

func main_menu_init():
	weapon_manager = WeaponManager.new()
	health = Health.new()
	player_body = PlayerController.new()

	if PlayerSetup.base_stats.is_empty():
		PlayerSetup.base_stats = base_stats	
		for base_stat in BaseStat.BaseStatType.keys():
			var stat:= BaseStat.new()
			stat.base_type = BaseStat.BaseStatType[base_stat]
			base_stats.append(stat)
		init_base_stats()
	else:
		base_stats = PlayerSetup.base_stats

func combat_init():
	for stat in PlayerSetup.base_stats:
		base_stats.append(stat.duplicate(true))

	weapon_manager = $"../Weapon Manager"
	health = $"../Health"
	player_body = $"../Body"
	
	if health is Health:
		health.init_health(get_stat(BaseStat.BaseStatType.MAX_LIFE).value)
	
	init_stat_signals()	

func init_base_stats():
	var base_mods: Array[StatMod]
	#Create modifiers for base stats
	var life_mod := StatMod.new()
	life_mod.value = max_life
	life_mod.stat_mod_type = StatMod.StatModType.FLAT
	base_mods.append(life_mod)

	var damage_mod := StatMod.new()
	damage_mod.value = damage
	damage_mod.stat_mod_type = StatMod.StatModType.FLAT	
	base_mods.append(damage_mod)

	var fire_rate_mod := StatMod.new()
	fire_rate_mod.value = fire_rate
	fire_rate_mod.stat_mod_type = StatMod.StatModType.FLAT	
	base_mods.append(fire_rate_mod)

	var movement_speed_mod := StatMod.new()
	movement_speed_mod.value = movement_speed
	movement_speed_mod.stat_mod_type = StatMod.StatModType.FLAT	
	base_mods.append(movement_speed_mod)

	var bullet_life_time_mod:= StatMod.new()
	bullet_life_time_mod.value = weapon_manager.bullet_lifetime
	bullet_life_time_mod.stat_mod_type = StatMod.StatModType.FLAT
	base_mods.append(bullet_life_time_mod)

	var spread_angle_mod:= StatMod.new()
	spread_angle_mod.value = weapon_manager.spread_angle
	spread_angle_mod.stat_mod_type = StatMod.StatModType.FLAT
	base_mods.append(spread_angle_mod)

	var spread_variation_mod:= StatMod.new()
	spread_variation_mod.value = weapon_manager.spread_variation
	spread_variation_mod.stat_mod_type = StatMod.StatModType.FLAT
	base_mods.append(spread_variation_mod)

	var bullet_speed_mod:= StatMod.new()
	bullet_speed_mod.value = weapon_manager.bullet_speed
	bullet_speed_mod.stat_mod_type = StatMod.StatModType.FLAT
	base_mods.append(bullet_speed_mod)

	for statmod in base_mods:
		statmod.source = GearResource.GearType.BASE
		
	#Init health
	if health is Health:
		health.init_health(max_life)
	
	#Apply modifiers for base stats
	base_stats[BaseStat.BaseStatType.MAX_LIFE].apply_stat(life_mod)
	base_stats[BaseStat.BaseStatType.DAMAGE].apply_stat(damage_mod)
	base_stats[BaseStat.BaseStatType.FIRE_RATE].apply_stat(fire_rate_mod)
	base_stats[BaseStat.BaseStatType.MOVEMENT_SPEED].apply_stat(movement_speed_mod)
	base_stats[BaseStat.BaseStatType.BULLET_LIFE_TIME].apply_stat(bullet_life_time_mod)
	base_stats[BaseStat.BaseStatType.SPREAD_ANGLE].apply_stat(spread_angle_mod)
	base_stats[BaseStat.BaseStatType.SPREAD_VARIATION].apply_stat(spread_variation_mod)
	base_stats[BaseStat.BaseStatType.BULLET_SPEED].apply_stat(bullet_speed_mod)


func add_mod_to_base_stat(stat_mod : StatMod, stat_type : BaseStat.BaseStatType):
	base_stats[stat_type].apply_stat(stat_mod)

func remove_all_stats_based_on_source(gear_type: GearResource.GearType):
	for base_stat in base_stats:
		base_stat.remove_stat(gear_type)

func remove_mod_from_base_stat(stat_type : BaseStat.BaseStatType, source: GearResource.GearType):
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

func update_spread_angle(value: float):
	weapon_manager.spread_angle = value

func update_spread_variation(value: float):
	weapon_manager.spread_variation = value

func update_bullet_speed(value: float):
	weapon_manager.bullet_speed = value

#Connect signals for base stats
func init_stat_signals():
	base_stats[BaseStat.BaseStatType.MAX_LIFE].on_value_changed.connect(update_max_life)
	base_stats[BaseStat.BaseStatType.MOVEMENT_SPEED].on_value_changed.connect(update_movement_speed)
	base_stats[BaseStat.BaseStatType.FIRE_RATE].on_value_changed.connect(update_fire_rate)
	base_stats[BaseStat.BaseStatType.PROJ_COUNT].on_value_changed.connect(update_extra_prop_count)
	base_stats[BaseStat.BaseStatType.BULLET_LIFE_TIME].on_value_changed.connect(update_bullet_lifetime)
	base_stats[BaseStat.BaseStatType.PIERCE].on_value_changed.connect(update_pierce)
	base_stats[BaseStat.BaseStatType.SPREAD_ANGLE].on_value_changed.connect(update_spread_angle)
	base_stats[BaseStat.BaseStatType.SPREAD_VARIATION].on_value_changed.connect(update_spread_variation)
	base_stats[BaseStat.BaseStatType.BULLET_SPEED].on_value_changed.connect(update_bullet_speed)
