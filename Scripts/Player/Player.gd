extends CharacterBody2D

const bounceForce : int = 600
const toLineForce : int= 160
var windowSizeX = DisplayServer.window_get_size().x
var canStopMomentum: bool = true 

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		canStopMomentum = true
		velocity.y += -bounceForce

	_move_bethween_lines()
	_move_player_down()
	move_and_slide()
	
func _move_bethween_lines():
	if Input.is_action_just_pressed("to_left_line"):
		if(position.x - toLineForce >= 0):
			position.x += -toLineForce
	elif  Input.is_action_just_pressed("to_right_line"):
		if(position.x + toLineForce <= windowSizeX):
			position.x += toLineForce 

func _move_player_down():
	if Input.is_action_just_pressed("player_down") && canStopMomentum:
		canStopMomentum = false
		velocity.y = 0
