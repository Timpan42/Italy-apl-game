extends CharacterBody2D

const maxFallVelocity = 500 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const bounceForce : float = 680
var canStopMomentum : bool = true 
var bounsTimer : float = 0

const toLineForce : int = 160
var windowSizeX = DisplayServer.window_get_size().x

var onCheckPoint : bool = true 
var lastCheckPoint : int;

signal playerBounce
signal playerOnCheckPoint(onCheckPoint)
signal playerStartedGame()

func _physics_process(delta):
	if !onCheckPoint:
		NotOnCheckPoint(delta)
	else:
		WhenOnCheckPoint()


func NotOnCheckPoint(delta):
	if velocity.y < maxFallVelocity:
		velocity.y += 587 * delta
		bounsTimer += delta
	if is_on_floor():
		print(bounsTimer)
		bounsTimer = 0
		canStopMomentum = true
		playerBounce.emit()
		velocity.y += -bounceForce
		
	if Input.is_action_just_pressed("to_left_line"):
		if position.x - toLineForce >= 0:
			_move_bethween_lines(-toLineForce)
	elif  Input.is_action_just_pressed("to_right_line"):
		if position.x + toLineForce <= windowSizeX:
			_move_bethween_lines(toLineForce)
			
	_move_player_down()
	move_and_slide()

func WhenOnCheckPoint():
	velocity.y = 0

	if Input.is_action_just_pressed("start_player_movement"):
		_start_game()

	if Input.is_action_just_pressed("to_left_line"):
		if position.x - toLineForce >= 0:
			_move_bethween_lines(-toLineForce)
	elif  Input.is_action_just_pressed("to_right_line"):
		if position.x + toLineForce <= windowSizeX:
			_move_bethween_lines(toLineForce)
		
	move_and_slide()

func _start_game():
	onCheckPoint = false
	velocity.y += - bounceForce
	playerBounce.emit()
	playerOnCheckPoint.emit(onCheckPoint)
	playerStartedGame.emit()

func _move_bethween_lines(force : int): 
	var tween = get_tree().create_tween()
	var playerMovePosition = position.x
	playerMovePosition += force
	tween.tween_property(self, "position", Vector2(playerMovePosition, position.y), 0.1).set_trans(Tween.TRANS_QUAD)

func _move_player_down():
	if Input.is_action_just_pressed("player_down") && canStopMomentum:
		canStopMomentum = false
		velocity.y = 0 

func _on_check_points_player_entered(Id):
	lastCheckPoint = Id
	onCheckPoint = true
	playerOnCheckPoint.emit(onCheckPoint)
	
