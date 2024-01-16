extends Resource
class_name WeaponXpTree

var base_res_path: String

@export var level: int
@export var level_1: Array[UpgradeResource]
@export var level_2: Array[UpgradeResource]
@export var level_3: Array[UpgradeResource]
@export var level_4: Array[UpgradeResource]
@export var level_5: Array[UpgradeResource]

var tree# = [Level_1, Level_2, Level_3, Level_4, Level_5] #int , Level Array

