class_name Drop extends Area2D
## Base node for any item that drops, and player can pick up

func _on_area_entered(area):
	if area.is_in_group("Player"):
		print("player enter")


func _on_area_exited(area):
	if area.is_in_group("Player"):
		print("player exit")
	
