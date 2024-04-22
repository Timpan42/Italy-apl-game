extends CharacterBody2D

@export var gravity = 980
@export var maxFallVelocity = 980

@export var toLine : Array[int] = [] 
var lineIndex = 1

var bounsTimer = 0 
var windowSizeX = DisplayServer.window_get_size().x

var canMove = false
signal startGame

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("start_player_movement"):
		canMove = true
		startGame.emit()
	
	if !canMove:
		return
	if velocity.y < maxFallVelocity:
		velocity.y += gravity * delta
	
	bounsTimer += delta
	
	if is_on_floor():
		print(bounsTimer)
		bounsTimer = 0
		for index in get_slide_collision_count():
			var collision = get_slide_collision(index).get_collider()
			var pushForce = collision._get_push_player_force() 
			gravity = collision._get_change_gravity()
			velocity.y -= pushForce
	
	if Input.is_action_just_pressed("to_left_line"):
		if lineIndex - 1 >= 0:
			_move_bethween_lines(-1)
	elif  Input.is_action_just_pressed("to_right_line"):
		if lineIndex + 1 <= toLine.size() - 1:
			_move_bethween_lines(1)
	
	move_and_slide()

func _move_bethween_lines(index): 
	lineIndex += index
	position.x = toLine[lineIndex]
