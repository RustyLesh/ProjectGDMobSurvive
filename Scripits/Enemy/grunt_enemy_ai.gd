extends EnemyMovementAI
class_name GruntMovementAI
#Enemy moves to players position

func get_target_position(current_pos: Vector2, player_pos: Vector2) -> Vector2:
	return player_pos