extends Area2D
class_name Bullet
signal destroy()

#Projectile movement 

@export var speed = 20
##Duration in seconds
@export var lifetime := 1
@export var base_damage := 1
@export var pierce: int #Max number of enemies can pierce
@export var pierce_counter:int = 0 #Keeps track of how many enemies has pierced

var on_hit_effects: Array[OnHitEffect]

var dead = false

func _ready():
	start_kill_timer()

func _physics_process(delta):
		move_local_y(-speed * delta)

func _on_body_entered(body):
	var parent_body = body.get_parent()
	if parent_body is Entity:
		if !parent_body.is_dead:
			parent_body.take_damage(base_damage)
			#Applies hit effects if there are any
			if on_hit_effects.size() > 0:
				for hit_effect in on_hit_effects:
					hit_effect.trigger_effect(body.get_parent())
			#Destroy self if 0 pierces remain
			if pierce_counter >= pierce:
				call_deferred("kill_self")
			else: 
				pierce_counter += 1

#after life time of bullet runns out, runs the kill function
func start_kill_timer():
	await get_tree().create_timer(lifetime).timeout
	call_deferred("kill_self")

#disables collision and sprite of bullet then calls destroy for particle emiter.
func kill_self():
	if !dead:
		$Sprite2D.visible = false
		$CollisionShape2D.disabled = true
		destroy.emit()

#after particles have disapeared, clears from memory
func _on_gpu_particles_2d_kill(time):
	dead = true
	await get_tree().create_timer(time).timeout
	queue_free()

