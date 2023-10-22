
extends "res://Scripits/entity.gd"
#Main enemy functions

enum EnemyTypes{BASIC, TURRET}

@export var enemy_resource = preload("res://Scripits/Enemy/enemy_resource.gd")
@onready var sprite_node = $Body/Sprite2D

func _on_health_died():
	queue_free()

func _ready():
	sprite_node.texture = enemy_resource.sprite
	if health is Health:
		health.init_health(enemy_resource.max_health)
		

