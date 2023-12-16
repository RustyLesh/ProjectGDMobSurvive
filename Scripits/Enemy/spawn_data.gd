extends Resource

class_name SpawnDataResource

@export var time_start: int
@export var time_end: int
@export var enemy_resource: EnemyResource
@export var spawn_animation: SpriteFrames
@export var enemy_amount: int
@export var spawn_delay: int

var spawn_delay_counter := 9999
