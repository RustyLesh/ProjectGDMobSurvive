extends Area2D
class_name ExplosionAreaCheck

@onready var collision_shape = $CollisionShape2D.shape as CircleShape2D


func explode(center_position: Vector2, radius: float) -> Array[Node2D] :
    global_position = center_position
    collision_shape.radius = radius
    return get_overlapping_bodies()
