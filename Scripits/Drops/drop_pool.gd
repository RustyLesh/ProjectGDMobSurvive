class_name DropPool extends Resource
## Stores [DropResource]. used to roll a drop from the drop pool by adding all the weights.

@export var drop_pool: Array[DropResource]

var total_pool_weight: float = 0
var weight_counter: float = 0

## Roll a drop from the drop pool
func get_drop() -> Dictionary:
	#return if no drops
	if drop_pool.size() <= 0:
		return {}

	total_pool_weight = 0
	weight_counter = 0
	for drop in drop_pool:
		total_pool_weight += drop.drop_weight

	var drop: Variant
	var has_rolled_drop:= false
	var roll = randf_range(0, total_pool_weight)

	for drop_resource in drop_pool:
		weight_counter += drop_resource.drop_weight
		if roll <= weight_counter:
			drop = drop_resource.drop_node.instantiate()
			drop_resource.init_gear_drop(drop)
			has_rolled_drop = true
			
			return {
				"drop": drop,
				"has_rolled_drop": has_rolled_drop,
			}
	return {
		"drop": drop,
		"has_rolled_drop": has_rolled_drop,
	}
	


