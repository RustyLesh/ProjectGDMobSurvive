extends Node
class_name XPManager
#Keeps count of xp obtained in level for player.
signal on_xp_changed(current_xp: float, xp_for_next_level: float, level : int)
signal on_level(level : int)

@export var current_xp : float 
@export var current_total_xp : float
@export var xp_for_next_level : float

@export var xp_multiplier : float
@export var current_level : int

##Higher = more xp needed to level
@export var xp_constant: float = 0.2

#for checking if level changed
var level_buffer

func xp_gained(value : float):
	#add to current xp
	current_total_xp += value
	level_buffer = current_level
	current_level = xp_constant * sqrt(current_total_xp)
	
	#if level changed from buffer
	if level_buffer != current_level: 
		on_level.emit(current_level)
	
	#Checks if level 0 
	if current_level > 1:
		current_xp = current_total_xp - (pow(((current_level - 1) / xp_constant ), 2))
	else:
		current_xp = current_total_xp
	
	xp_for_next_level = pow(((current_level + 1) / xp_constant ), 2)
	
	on_xp_changed.emit(current_xp, xp_for_next_level, current_level)

