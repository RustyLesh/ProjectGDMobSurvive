extends Node
#Use inputs to test actions

@export var drop_colours: DropColours
@export var drop_pool: Array[DropResource]
@onready var player: Player = $"../Player"

var total_pool_weight: float
var weight_counter: float = 0

func _ready():
	for drop in drop_pool:
		total_pool_weight += drop.drop_weight

func _input(event):
	if event.is_action_pressed("shoot"):
		weight_counter = 0
		var roll = randf_range(0, total_pool_weight)
		for drop_resource in drop_pool:
			weight_counter += drop_resource.drop_weight
			if roll <= weight_counter:
				var new_drop = drop_resource.drop_node.instantiate()
				add_child(new_drop)
				new_drop.global_position = player.player_body.global_position
				new_drop.modulate = drop_colours.colours_array[drop_resource.rarity]
				new_drop.gear_resource = drop_resource.gear_resource
				return



# 	if event.is_action_pressed("action_1"):
# 		sprite.modulate = drop_colours.uncommon_drop

# 	if event.is_action_pressed("action_2"):
# 		sprite.modulate = drop_colours.rare_drop

# 	if event.is_action_pressed("action_3"):
# 		sprite.modulate = drop_colours.boss_drop

