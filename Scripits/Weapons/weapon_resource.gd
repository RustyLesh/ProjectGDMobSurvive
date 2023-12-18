extends Resource
class_name WeaponResource
#Holds data for player weapon

@export var icon: CompressedTexture2D
@export var weapon_name: String
@export var description: String
@export var weapon: Resource
@export var upgrades: Array[UpgradeResource]
