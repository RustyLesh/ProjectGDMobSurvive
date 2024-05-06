class_name Lazor extends RayCast2D

@onready var line: Line2D = $Line2D

var is_casting = false : set = set_is_casting

func _ready():
	set_physics_process(false)
	line.points[1] = Vector2.ZERO

func toggle_attack(player_pos: Vector2):
	look_at(player_pos)
	self.is_casting = !is_casting

func _physics_process(delta):
	var cast_point = target_position
	force_raycast_update()

	if is_colliding():
		cast_point = to_local(get_collision_point())

	line.points[1] = cast_point
	print("target: ", cast_point)

func set_is_casting(cast: bool):
	is_casting = cast

	if is_casting:
		appear()
	else:
		disappear()

	set_physics_process(is_casting)

func appear():
	print("appear")
	var tween = get_tree().create_tween()
	tween.tween_property(line, "width", 10, 0.2)

func disappear():
	var tween = get_tree().create_tween()
	tween.tween_property(line, "width", 0, 0.2)
