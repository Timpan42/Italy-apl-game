extends CharacterBody2D
@export var gravity : int

@export var movementSpeed : float

var collitionTimer = 0 
var placeInSong = 1
var canMove = false
var stopGravity = false

var lastDirectionBlockInteraction
var moveHorizontal = true
var onDirectionBlock = false
var moveDirection = 1

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
	
	if moveHorizontal:
		velocity.x = movementSpeed * moveDirection
		velocity.y = 0
	else:
		velocity.y = movementSpeed * moveDirection
		velocity.x = 0
	
	if !stopGravity:
		velocity.y = gravity * delta
	
	collitionTimer += delta
	
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
	print("change direction")
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
	print("ok")

func _on_great_collider():
	onGreat = true
	print("great")

func _on_perfect_collider():
	onPerfect = true
	print("perfect")

func _on_audio_sync_player_player_collide():
	print(collitionTimer)
	print(placeInSong)
	placeInSong += 1
	collitionTimer = 0
