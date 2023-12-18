extends GPUParticles2D
#Particles for use on bullet. Made to die when bullet dies after specified time. 
#Purpose to have already created particles linger after bullet death, becuase if not,
#all particles dissapear immediatly on bullet death, looking unatural.

signal kill(time)

func destroy():
	emitting = false
	kill.emit(lifetime)

func _on_bullet_destroy():
	destroy()
