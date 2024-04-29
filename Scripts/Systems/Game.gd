extends Node2D

@export var startIndex : int = 0
@export var songOffset : float = 0
@export var xOffset : float
@export var yOffset : float

var minPlatform = 0
var maxPlatform = 9
var platformStart
var gameStarted = false

signal startGame(startIndex : int, songOffset : float)
signal changePlayerStartPosition(pos : Vector2, direction : String, turnOfGravity : bool)

func _process(_delta):
	if Input.is_action_just_pressed("escape_input"):
		get_tree().quit()

func _on_player_start_game():
	if(startIndex != 0):
		for childeIndex in range($"../SectionHolder".get_child_count()):
			if startIndex >= minPlatform && startIndex <= maxPlatform:
				platformStart = $"../SectionHolder".get_child(childeIndex).get_child(startIndex - childeIndex * 10)
				break
			else:
				minPlatform += 10
				maxPlatform += 10
		var pos = platformStart.position
		pos = Vector2(pos.x + xOffset, pos.y + yOffset)
		var direction = platformStart._get_sending_player_direction()
		var turnOfGravity = platformStart._get_turn_of_gravity()
		changePlayerStartPosition.emit(pos, direction, turnOfGravity)

	gameStarted = true
	startGame.emit(startIndex, songOffset)

func _on_audio_sync_player_is_playing():
	pass # Replace with function body.

func _on_audio_sync_player_finished():
	pass # Replace with function body.

func _on_player_send_position(pos):
	$SavePositionData._update_data(pos)
