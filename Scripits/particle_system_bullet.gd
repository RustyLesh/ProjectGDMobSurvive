extends GPUParticles2D

signal kill(time)

func destroy():
	emitting = false
	kill.emit(lifetime)

func _on_bullet_destroy():
	destroy()
