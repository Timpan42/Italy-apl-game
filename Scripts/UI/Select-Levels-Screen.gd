extends Control

var levelHolder : Array 
var player : Node2D
var levelIndex = 0 

func _ready():
	levelHolder = get_children()
	player = $"../Player"


func _process(delta):
	if Input.is_action_just_pressed("right_input"):
		levelIndex += 1
		player.global_position = levelHolder[levelIndex].global_position 
	elif Input.is_action_just_pressed("left_input"):
		levelIndex -= 1
		player.global_position = levelHolder[levelIndex].global_position 

