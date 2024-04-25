class_name Rocket extends Bullet

@export var area: float
#@export var explosion_damage: int
var enemies_in_radius: Array[Node2D]

func kill_self():
	enemies_in_radius = BulletHelper.explosion_helper.explode(position, area)
	BulletHelper.create_explosion_sprite(area, position)
	for enemy in enemies_in_radius:
		enemy.get_parent().take_damage(base_damage / 2)
	super()
