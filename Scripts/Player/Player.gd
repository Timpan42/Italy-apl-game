extends CharacterBody2D
@export var gravity : int

@export var movementSpeed : float

var canMove = false
var stopGravity = true

var lastDirectionBlockInteraction
var moveHorizontal = true
var onDirectionBlock = false
var moveDirection = 1

var playerDidDirectionInput = false
var points = 0
var onOk = false
var onGreat = false
var onPerfect = false 

var moveTimer = 0
var moveTime = true

signal startGame

func _process(delta):
	if Input.is_action_just_pressed("start_input") && !canMove:
		canMove = true
		startGame.emit()
	
	if !canMove:
		return
	
	_player_direction_input()
	
	if moveHorizontal:
		velocity.x = movementSpeed * moveDirection
		velocity.y = 0
	else:
		velocity.y = movementSpeed * moveDirection
		velocity.x = 0
	
	if !stopGravity:
		velocity.y = gravity * delta
	
	if position.x > 720 && moveTime:
		print(moveTimer)
		moveTime = false
	else:
		moveTimer += delta
	
	move_and_slide()

func _collide_with_direction_block(direction : String, trunOfGravity : bool):
	match direction: 
		"up":
			_change_player_movement(-1, false)
		"down": 
			_change_player_movement(1, false)
		"left":
			_change_player_movement(-1, true)
		"right":
			_change_player_movement(1, true)
		_: 
			print("no direction")
	lastDirectionBlockInteraction = direction
	stopGravity = trunOfGravity
	onDirectionBlock = true
	playerDidDirectionInput = true

func _change_player_movement(direction : int, horizontal):
	moveHorizontal = horizontal
	moveDirection = direction

func _exited_direction_block():
	onDirectionBlock = false
	onOk = false
	onGreat = false
	onPerfect = false 


func _player_direction_input():
	if onDirectionBlock && playerDidDirectionInput:
		if Input.is_action_just_pressed("up_input"):
			_dose_input_match_direction("up")
		elif Input.is_action_just_pressed("down_input"):
			_dose_input_match_direction("down")
		elif Input.is_action_just_pressed("left_input"):
			_dose_input_match_direction("left")
		elif Input.is_action_just_pressed("right_input"):
			_dose_input_match_direction("right")


func _dose_input_match_direction(direction : String):
	playerDidDirectionInput = false
	if  direction == lastDirectionBlockInteraction:
		_point_counter()
	else:
		print("Wrong input") 

func _point_counter():
	if onOk:
		if onGreat:
			if onPerfect:
				points += 100
			else: 
				points += 50
		else: 
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
	_collide_with_direction_block(direction, turnOfGravity)
	
