class_name AbilityResource extends Resource
## Base resource for player abilities
## Used with [EnemySpawnManager]

@export var ability_name: String
@export var ability_icon: Texture2D

func use_ability():
    print(ability_name)