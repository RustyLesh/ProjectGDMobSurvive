extends Node

@onready var explosion_helper: ExplosionAreaCheck = $ExplosionAreaCheck
@onready var on_hit_effects_helper: OnHitEffectsHelper = $"On Hit Effects Helper"
@onready var explosion_circle_path: = preload("res://Explosion Circle.tscn")

func create_explosion_sprite(size: int, position: Vector2):
    var explosion_sprite_instace = explosion_circle_path.instantiate() as ExplosionCircleSrpite
    explosion_sprite_instace.set_size(size)
    explosion_sprite_instace.position = position
    add_child(explosion_sprite_instace)
    await get_tree().create_timer(0.1).timeout
    explosion_sprite_instace.queue_free()


