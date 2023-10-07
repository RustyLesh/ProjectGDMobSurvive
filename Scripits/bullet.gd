extends Area2D

@export var speed = 20

func _physics_process(delta):
		move_local_y(-speed * delta)

func _on_body_entered(body):
	print("Hit: " + body.name)
	
