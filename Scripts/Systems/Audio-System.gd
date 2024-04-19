extends AudioStreamPlayer

@export var bpm : float = 100
@export var songMeasures : int = 4 

var songPosition : float = 0
var songPositionBeats = 1
var secPerBeat = 60 / bpm
var lastBeat : int = 0
var beatsBeforeStart : int = 0
var onMeasure = 1

signal beat(songPositionBeats)
signal measure(onMeasure)
signal songIsPlaying(playing, songMeasures)
func _ready():
	secPerBeat = 60 / bpm

func _physics_process(_delta):
	if playing:
		songPosition = get_playback_position() + AudioServer.get_time_since_last_mix()
		songPosition -= AudioServer.get_output_latency()
		songPositionBeats = int(floor(songPosition / secPerBeat)) + beatsBeforeStart
		_report_beat()

func _report_beat():
	if lastBeat < songPositionBeats:
		if onMeasure > songMeasures:
			onMeasure = 1
		beat.emit(songPositionBeats)
		measure.emit(onMeasure)
		lastBeat = songPositionBeats
		onMeasure += 1

func _on_test_scene_start_song():
	play()
	songIsPlaying.emit(playing, songMeasures)

func _on_test_camra_move_start_song():
	play()
	songIsPlaying.emit(playing, songMeasures)
