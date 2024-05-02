extends CharacterBody2D
@export var gravity : int
@export var movementSpeed : float

@onready var getCircle = $Circle
@export var cirecleIncloseTimer : float

var canMove = false
var stopGravity = true

var lastDirectionBlockInteraction
var lastSecondDirection
var moveHorizontal = true
var onDirectionBlock = false
var moveDirection = 1
var moveSecondDirection = 0

var playerDidDirectionInput = false
var points = 0
var onOk = false
var onGreat = false
var onPerfect = false 

signal startGame

func _process(delta):
	if Input.is_action_just_pressed("start_input") && !canMove:
		canMove = true
		startGame.emit()
	
	if !canMove:
		return
	
	_player_direction_input()
	
	if moveSecondDirection != 0:
		velocity.y = movementSpeed * moveDirection
		velocity.x = movementSpeed * moveSecondDirection
	elif moveHorizontal && moveSecondDirection == 0:
		velocity.x = movementSpeed * moveDirection
		velocity.y = 0
	else:
		velocity.y = movementSpeed * moveDirection
		velocity.x = 0
	
	if !stopGravity:
		velocity.y = gravity * delta

	move_and_slide()


func _collide_with_direction_block(direction : String, secondDirection : String):
	lastDirectionBlockInteraction = direction
	lastSecondDirection = secondDirection
	onDirectionBlock = true
	playerDidDirectionInput = true
	_inclose_circle()

func _inclose_circle():
	var tween = get_tree().create_tween()
	getCircle.scale = Vector2(0,0)
	getCircle.visible = true
	tween.tween_property(getCircle, "scale" ,Vector2(0.7,0.7), cirecleIncloseTimer)
	await tween.finished
	getCircle.visible = false

func _send_direction(trunOfGravity : bool):
	var secondDirection = _side_directions()
	match lastDirectionBlockInteraction: 
		"up":
			if secondDirection != 0:
				_change_player_movement(-1, secondDirection, false)
			else :
				_change_player_movement(-1, 0, false)
		"down": 
			if secondDirection != 0:
				_change_player_movement(1, secondDirection, false)
			else :
				_change_player_movement(1, 0, false)
		"left":
			_change_player_movement(-1, 0, true)
		"right":
			_change_player_movement(1, 0, true)
		_: 
			print("no direction")
	stopGravity = trunOfGravity

func _side_directions():
	var direction
	if lastSecondDirection == "left":
		direction = -1
	elif lastSecondDirection == "right":
		direction = 1
	else: 
		direction = 0
	return direction

func _change_player_movement(direction : int, secondDirection : int, horizontal):
	moveHorizontal = horizontal
	moveDirection = direction
	moveSecondDirection = secondDirection

func _exited_direction_block():
	onDirectionBlock = false
	onOk = false
	onGreat = false
	onPerfect = false 


func _player_direction_input():
	if onDirectionBlock && playerDidDirectionInput && lastSecondDirection != "non":
		if Input.is_action_just_pressed("angled_input"):
			_dose_input_match_direction("double", true)
	elif onDirectionBlock && playerDidDirectionInput && lastSecondDirection == "non":
		if Input.is_action_just_pressed("up_input"):
			_dose_input_match_direction("up", false)
		elif Input.is_action_just_pressed("down_input"):
			_dose_input_match_direction("down", false)
		elif Input.is_action_just_pressed("left_input"):
			_dose_input_match_direction("left", false)
		elif Input.is_action_just_pressed("right_input"):
			_dose_input_match_direction("right", false)

func _dose_input_match_direction(direction : String, doubleInput : bool):
	playerDidDirectionInput = false
	if direction == "double" && doubleInput:
		_point_counter() 
	elif direction == lastDirectionBlockInteraction && !doubleInput:
		_point_counter() 
	else:
		print("Wrong input") 

func _point_counter():
	if onPerfect:
		points += 100
	elif onGreat:
		points += 50
	elif onOk:
		points += 25
	else:
		print("no points")
	print(points)

func _on_ok_collider():
	onOk = true


func _on_great_collider():
	onGreat = true


func _on_perfect_collider():
	onPerfect = true


func _on_audio_sync_player_player_collide(dataIndex : int, seconds: float):
	print(seconds)
	print(dataIndex)

func _on_game_manager_change_player_start_position(pos, direction, turnOfGravity):
	position = pos
	lastDirectionBlockInteraction = direction
	_send_direction(turnOfGravity)
	
