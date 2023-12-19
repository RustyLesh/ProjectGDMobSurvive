extends Node
#Stores player data for going between main menu and combat levels

@export var weapon: WeaponResource
@export var weapon_upgrade_pool: Array[UpgradeResource]
@export var gear_upgrade_pool: Array[UpgradeResource]

@export var base_stats: Array[BaseStat]

@export var inventory: Array[Gear]
@export var gear_drops: Array[Gear]

