extends OnHitEffect
class_name ChainLightningOnHit

@export var proc_range: float
@export var max_chain_count: int
var explosion_area_check
var enemies_in_area: Array[Node2D]
var enemy_proc_buffer: EnemyNode
var enemy_hit
var on_hit_effects_helper

func trigger_effect(enemy: EnemyNode):
	if explosion_area_check == null:
		explosion_area_check = enemy.get_tree().get_first_node_in_group("Explosion Area Check")
		on_hit_effects_helper = enemy.get_tree().get_first_node_in_group("On Hit Effects Helper")
	if explosion_area_check is ExplosionAreaCheck:
		enemies_in_area = explosion_area_check.explode(enemy.character_body.global_position, proc_range)
		enemy_proc_buffer = enemy
		enemy_hit = enemy

		var pos_array: Array[Vector2]
		
		for i in max_chain_count:
			if enemies_in_area.size() < 1: #If no enemies are found, end chain effect
				return
			pos_array.append(enemy_hit.character_body.global_position)
			enemies_in_area.shuffle()
			enemy_proc_buffer = enemy_hit
			enemy_hit = enemies_in_area[0].get_parent()
			if on_hit_effects_helper is OnHitEffectsHelper:
				enemy_hit.take_damage(value)
				enemies_in_area = explosion_area_check.explode(enemy_hit.character_body.global_position, proc_range)
			on_hit_effects_helper.chain_line_effect(pos_array)
	

