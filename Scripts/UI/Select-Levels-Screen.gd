extends Control

var levelHolder : Array 
var player : Node2D
var levelIndex = 0 

signal changeLevel(level)

func _ready():
	levelHolder = get_children()
	player = $"../Player"


func _process(_delta):
	if Input.is_action_just_pressed("right_input") && levelIndex != levelHolder.size() - 1:
		levelIndex += 1
		player.global_position = levelHolder[levelIndex].global_position 
	elif Input.is_action_just_pressed("left_input") && levelIndex != 0:
		levelIndex -= 1
		player.global_position = levelHolder[levelIndex].global_position 

	if Input.is_action_just_pressed("start_input"):
		_send_level(levelHolder[levelIndex]._emit_level())

func _send_level(level):
	if level == null:
		return
	else:
		changeLevel.emit(level)
