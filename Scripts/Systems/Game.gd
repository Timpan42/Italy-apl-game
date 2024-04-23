extends Node2D

var gameStarted = false

signal startGame()

func _process(delta):
	if Input.is_action_just_pressed("escape_input"):
		$SavePositionData._save_position_data()
		get_tree().quit()

func _on_player_start_game():
	gameStarted = true
	startGame.emit()

func _on_audio_sync_player_is_playing():
	pass # Replace with function body.

func _on_audio_sync_player_finished():
	pass # Replace with function body.

func _on_player_send_position(position):
	$SavePositionData._update_data(position)
