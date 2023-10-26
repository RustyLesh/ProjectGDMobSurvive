extends Area2D
class_name Drop

func _on_area_entered(area):
	if area.is_in_group("Player"):
		print("player enter")


func _on_area_exited(area):
	if area.is_in_group("Player"):
		print("player exit")
	
func pick_up():
	pass

