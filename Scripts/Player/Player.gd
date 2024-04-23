extends CharacterBody2D

const  toColumn : Array[int] = [85, 245,405] 
var columnIndex = 1

var bounsTimer = 0 
var jumpId = 1
var windowSizeX = DisplayServer.window_get_size().x

var canMove = false
signal startGame

func _process(delta):
	if Input.is_action_just_pressed("start_player_movement"):
		canMove = true
		startGame.emit()
	
	if !canMove:
		return
	
	bounsTimer += delta
	
	#_inputs_move_column()
	move_and_slide()

func _bouns():
	var tween

func _inputs_move_column():
	if Input.is_action_just_pressed("to_left_line"):
		if columnIndex - 1 >= 0:
			_move_bethween_columns(-1)
	elif  Input.is_action_just_pressed("to_right_line"):
		if columnIndex + 1 <= toColumn.size() - 1:
			_move_bethween_columns(1)

func _move_bethween_columns(index): 
	columnIndex += index
	position.x = toColumn[columnIndex]

func _on_audio_sync_player_player_jump():
	print(bounsTimer)
	print(jumpId)
	jumpId += 1
	bounsTimer = 0
