extends Drop
class_name XP_Drop

var value: float

func XP_Init(xp_value: float):
	value = xp_value

func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.get_parent() is Player:
			body.get_parent().xp_pickup(value)
		queue_free()

func pick_up():
	pass
