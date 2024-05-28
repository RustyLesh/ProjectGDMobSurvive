class_name OnKillExplode extends OnKillEffect

@export var size = 50
@export var damage = 10

func trigger_effect(object: Entity):
	BulletHelper.create_explosion_sprite(size, object.position)
	var hit_bodies = BulletHelper.explosion_helper.explode(object.position, size)
	for body in hit_bodies:
		var entity = body.get_parent()
		if entity is Entity:
			print("Explode hit")
			entity.take_damage(damage)