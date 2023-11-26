extends Area2D
class_name Bullet
signal destroy()

@export var speed = 20
@export var lifetime := 1
@export var base_damage = 1
@export var pierce_counter:int = 0
@export var pierce: int

var on_hit_effects: Array[OnHitEffect]

var dead = false

func _ready():
	start_kill_timer()

func _physics_process(delta):
		move_local_y(-speed * delta)

#dies on collision
func _on_body_entered(body):
	if body.get_parent() is Entity:
		body.get_parent().take_damage(base_damage)
		if on_hit_effects.size() > 0:
			for hit_effect in on_hit_effects:
				hit_effect.trigger_effect(body.get_parent())
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

