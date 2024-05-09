class_name ShapeCastLazor extends ShapeCast2D

@onready var line: Line2D = $Line2D

var damage: int
var is_damaging: bool = false

func _ready():
	#set_physics_process(false)
	line.points[1] = Vector2.ZERO
	line.width = 0

func init(resource: TurretLazorResource):
	damage = resource.lazor_damage

func _physics_process(delta):
	var cast_point = target_position
	force_shapecast_update()

	if is_colliding():
		var first_hit = get_collision_point(0)
		cast_point = to_local(get_collision_point(0))
		var collision = get_collider(0).get_parent()
		if collision is Player:
			collision.take_damage(damage)

	line.points[1] = cast_point

