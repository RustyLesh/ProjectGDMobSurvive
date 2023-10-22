extends Resource
class_name EnemyResource

@export var enemy_name : String = "name"
@export var max_health : int = 10
@export var move_speed : int = 100
@export var sprite : CompressedTexture2D = preload("res://Art/Bubble.png")
@export var spawn_animation : SpriteFrames = preload("res://Objects/enemy_spawn_animations/default_spawn.tres")

