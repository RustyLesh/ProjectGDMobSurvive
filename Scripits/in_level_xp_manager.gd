extends Node
class_name XPManager
signal xp_changed(current_xp: float, xp_for_next_level: float, level : int)

@export var current_xp : float
@export var current_total_xp : float
@export var xp_for_next_level : float

@export var xp_multiplier : float
@export var current_level : int

@export var xp_constant: float = 0.3

func xp_gained(value : float):
	current_total_xp += value
	current_level = xp_constant * sqrt(current_total_xp)
	
	if current_level > 1:
		current_xp = current_total_xp - (pow(((current_level - 1) / xp_constant ), 2))
	else:
		current_xp = current_total_xp
	
	xp_for_next_level = pow(((current_level + 1) / xp_constant ), 2)
	
	xp_changed.emit(current_xp, xp_for_next_level, current_level)

