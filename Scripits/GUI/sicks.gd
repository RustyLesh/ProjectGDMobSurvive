class_name Sticks extends CanvasLayer

@onready var left_stick = $"Virtual joystick left"
@onready var right_stick = $"Virtual joystick right"
@onready var divider = $"Seperator"

func set_opacity(value: float):
	left_stick.modulate = Color(255,255,255, value)
	right_stick.modulate = Color(255,255,255, value)
	divider.modulate = Color(255,255,255, value)

