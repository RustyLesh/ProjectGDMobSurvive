class_name ExplosiveBullet extends Bullet

@export var explosion_radius:= 50
@export var explosion_damage:= 10


func _on_body_entered(body):
	var parent_body = body.get_parent()
	if parent_body is Entity:
		if !parent_body.is_dead:
			parent_body.take_damage(base_damage)
			#Applies hit effects if there are any
			if on_hit_effects.size() > 0:
				for hit_effect in on_hit_effects:
					var roll = randf()
					print("Chance: ", hit_effect._proc_chance, " Roll: ", roll)
					if roll <= hit_effect._proc_chance:
						hit_effect.trigger_effect(body.get_parent())
			#Destroy self if 0 pierces remain
			if pierce_counter >= pierce:
				explode_on_hit()
				call_deferred("kill_self")
			else: 
				pierce_counter += 1

func explode_on_hit():
	BulletHelper.create_explosion_sprite(explosion_radius, position)