extends OnHitEffect
class_name SlowOnHit

@export var duration: int #Seconds

func trigger_effect(enemy: EnemyNode):
	enemy.apply_slow_to_self(value, duration)
	print("Slow: ", value)
