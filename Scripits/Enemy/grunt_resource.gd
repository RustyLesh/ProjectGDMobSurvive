class_name ShellGruntResource extends EnemyResource

@export_category("Grunt Resource")
@export var move_speed : int = 100
@export var contact_damage: int
@export var sprite : CompressedTexture2D
@export var collision_shape: Shape2D
@export var collision_pos_offset: Vector2