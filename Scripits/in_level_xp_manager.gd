extends Node
class_name XPManager
signal on_xp_changed(current_xp: float, xp_for_next_level: float, level : int)
signal on_level(level : int)

@export var current_xp : float
@export var current_total_xp : float
@export var xp_for_next_level : float

@export var xp_multiplier : float
@export var current_level : int

@export var xp_constant: float = 0.3

var level_buffer #for checking if level changed
func xp_gained(value : float):
	current_total_xp += value
	level_buffer = current_level
	current_level = xp_constant * sqrt(current_total_xp)
	
	if level_buffer != current_level: #if level changed
		on_level.emit(current_level)

	if current_level > 1:
		current_xp = current_total_xp - (pow(((current_level - 1) / xp_constant ), 2))
	else:
		current_xp = current_total_xp
	
	xp_for_next_level = pow(((current_level + 1) / xp_constant ), 2)
	
	on_xp_changed.emit(current_xp, xp_for_next_level, current_level)

