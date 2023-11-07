extends Area2D
class_name Bullet
signal destroy()

@export var speed = 20
@export var lifetime := 1
@export var base_damage = 1
var dead = false

func _ready():
	start_kill_timer()

func _physics_process(delta):
		move_local_y(-speed * delta)

#dies on collision
func _on_body_entered(body):
	if body.get_parent() is Entity:
		body.get_parent().take_damage(base_damage)
		
	call_deferred("kill_self")


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
