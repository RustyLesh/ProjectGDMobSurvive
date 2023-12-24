extends Node
class_name TestData

var number_array = [0, 0, 0, 0]
@onready var options = $".."

func _ready():
	await get_tree().create_timer(.001).timeout

	options.update_ui()


