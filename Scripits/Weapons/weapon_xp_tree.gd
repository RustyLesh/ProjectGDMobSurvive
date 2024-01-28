extends Resource
class_name WeaponXpTree

var base_res_path: String

@export var weapon_level: int
@export var level_1: Array[GearModifier]
@export var level_2: Array[GearModifier]
@export var level_3: Array[GearModifier]
@export var level_4: Array[GearModifier]
@export var level_5: Array[GearModifier]

@export var tree_array = {}

func init_weapon_tree():
    tree_array[0] = level_1
    tree_array[1] = level_2
    tree_array[2] = level_3
    tree_array[3] = level_4
    tree_array[4] = level_5
