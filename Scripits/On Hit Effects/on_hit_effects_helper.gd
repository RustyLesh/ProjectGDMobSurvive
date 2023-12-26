extends Node
class_name OnHitEffectsHelper

@export var chain_line_effect_node: Resource 

func chain_line_effect(position_array: Array[Vector2]):
	var chain_object = load(str(chain_line_effect_node.resource_path)).instantiate()
	add_child(chain_object)
	
	if chain_object is EffectProcLine:
		chain_object.init_proc_line(position_array)
