class_name BoxSlimeShell extends KnightShell

func take_damage(damage):
	print("slime take: ", damage, " Hp: ", health.current_health)
	super(damage)