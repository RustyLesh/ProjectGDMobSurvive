extends CharacterBody2D

@export var force = 100

func _physics_process(delta):
	
	velocity = Vector2(0,0);
	
	if(Input.get_action_strength("move_left") > 0):
		velocity = Vector2(-force * Input.get_action_strength("move_left"), 0)
		move_and_slide()
		
	if(Input.get_action_strength("move_right") > 0):
		velocity = Vector2(force * Input.get_action_strength("move_right"), 0)
		move_and_slide()
	
	if(Input.get_action_strength("move_up") > 0):
		velocity = Vector2(0, -force * Input.get_action_strength("move_up"))
		move_and_slide()
		
	if(Input.get_action_strength("move_down") > 0):
		velocity = Vector2(0, force * Input.get_action_strength("move_down"))
		move_and_slide()


#
#	if(Input.is_action_pressed("move_left")):
#		apply_force(Vector2(-force, 0))
#
#	if(Input.is_action_pressed("move_up")):
#		apply_force(Vector2(0, -force))
#
#	if(Input.is_action_pressed("move_down")):
#		apply_force(Vector2(0, force))
