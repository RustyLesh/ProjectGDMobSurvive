extends Resource
class_name TestResource

@export var value: int 
@export var sprite_texture: Texture2D

func get_save_data() -> Dictionary:
    var path = resource_path
    print("path: ", path)
    return{
        "value": value,
        "resource_path": path,
        "sprite_texture": sprite_texture.resource_path,
    }