extends Resource
class_name AbilityResource

@export var ability_name: String
@export var ability_icon: Texture2D

func use_ability():
    print(ability_name)