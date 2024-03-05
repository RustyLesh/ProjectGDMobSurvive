extends Button
@export var difficulty: int

func _on_pressed():
	PlayerSetup.difficulty = difficulty
