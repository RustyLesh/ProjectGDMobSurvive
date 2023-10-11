extends Area2D

signal destroy()

@export var speed = 20
@export var lifetime := 1

func _ready():
	lifetime_kill()

func _physics_process(delta):
		move_local_y(-speed * delta)

func _on_body_entered(body):
	pass

func lifetime_kill():
	await get_tree().create_timer(lifetime).timeout
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	destroy.emit()

func _on_gpu_particles_2d_kill(time):
	await get_tree().create_timer(time).timeout
	queue_free()
