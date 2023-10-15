extends CharacterBody2D

@export var speed = 100

var move_input
var aim_input 

var deadzone = 0.25

func _physics_process(delta):
	
	move_input = Vector2(0,0);
	
	move_input.x = -Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	move_input.y = +Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	velocity = move_input * speed
	
	if move_input.length() > deadzone:
		move_and_slide()
		
	aim_input = Vector2.ZERO
	aim_input.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	aim_input.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	
	if aim_input.length() > deadzone:
		rotation = aim_input.angle() + PI/2
