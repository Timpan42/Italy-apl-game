extends Node2D

var songPositionBeats
var onMeasure
var maxMeasure

var playerStarted : bool = false
var playerOnCheckPoint : bool = false
var songIsPlaying : bool = false

var measuerLooped = 0

#@onready var platformHolder = $PlatformHolder

signal startSong

func _process(_delta):
	_start_song()
	

func _start_song():
	if !songIsPlaying:
		if playerStarted && !playerOnCheckPoint:
			$Timer.start()
			startSong.emit()

func _on_audio_system_beat(songPosition):
	songPositionBeats = songPosition 

func _on_audio_system_measure(measure):
	onMeasure = measure
	if onMeasure == 2 || onMeasure == maxMeasure:
		measuerLooped += 1
	#	_instantiate_platform()

func _instantiate_platform():
#	var platformPosition = Vector2(245, (platformHolder.position.y + 250) - 290 * measuerLooped)
#	_JSON_PLATFORM_SAVE._update_data(measuerLooped, platformPosition)
	measuerLooped += 1

func _on_audio_system_finished():
	#_JSON_PLATFORM_SAVE._save_to_file("1")
	print("song finished")

func _on_player_player_on_check_point(onCheckPoint):
	playerOnCheckPoint = onCheckPoint

func _on_player_player_started_game():
	playerStarted = true

func _on_audio_system_song_is_playing(playing, songMeasures):
	songIsPlaying = playing
	maxMeasure = songMeasures

func _on_timer_timeout():
	print(measuerLooped)
