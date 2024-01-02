extends Resource
class_name DropResource

enum DropType{
    GEAR,
    MATERIAL
}

enum Rarity {
    COMMON,
    UNCOMMON,
    RARE,
    BOSS,
}

@export var drop_weight: float
@export var rarity: Rarity
var drop_type: DropType
var drop_node: Resource