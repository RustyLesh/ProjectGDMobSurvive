extends Node

@onready var spawner = $EnemySpawner
const EnemySpawnerScript = preload("enemy_spawner.gd")

@export var enemy_scene = preload("res://Objects/basic_enemy_1.tscn")
@export var enemy_scene2 = preload("res://Objects/basic_enemy_2.tscn")

func _ready():
	if spawner is EnemySpawnerScript:
		spawner.add_enemy(enemy_scene)
		spawner.add_enemy(enemy_scene2)
