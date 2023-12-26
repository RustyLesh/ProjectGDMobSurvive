extends Line2D
class_name EffectProcLine

@onready var timer: Timer = $Timer
var line_linger_time: float = 0.05

func init_proc_line(position_array: Array[Vector2]):
	points = position_array.duplicate()
	timer.start(line_linger_time)

func delete_line():
	if points.size() == 0:
		queue_free()
	else: if points.size() > 0:
		remove_point((points.size() - 1))
