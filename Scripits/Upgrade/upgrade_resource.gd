extends Resource
class_name UpgradeResource

@export var name: String
@export var description: String
@export var icon : Texture2D

@export var upgrade: Upgrade
@export var added_upgrades: Array[UpgradeResource]
@export var max_uses: int
var current_uses: int = 0
