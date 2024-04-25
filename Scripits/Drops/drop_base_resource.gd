class_name DropResource extends Resource
## Base resource for items to be dropped from a [DropPool]

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