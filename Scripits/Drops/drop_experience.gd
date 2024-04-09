extends Drop
class_name XP_Drop
#Gives player xp when they enter the attached collider

var value: float

func XP_Init(xp_value: float):
	value = xp_value

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.get_parent().xp_pickup(value)
		await get_tree().create_timer(0.25).timeout
		queue_free()
