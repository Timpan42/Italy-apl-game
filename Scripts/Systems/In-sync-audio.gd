extends AudioStreamPlayer

const COMPENSATE_FRAMES = 2
const COMPENSATE_HZ = 60.0

signal isPlaying()

enum SyncSource {
	SYSTEM_CLOCK,
	SOUND_CLOCK,
}

var sync_source = SyncSource.SYSTEM_CLOCK

var seconds
var data : Array
var dataIndex = 0

signal playerCollide(dataIndex : int, seconds : float)

# Used by system clock.
var time_begin
var time_delay

func _process(_delta):
	if !is_playing():
		return

	var time = 0.0
	
	if sync_source == SyncSource.SYSTEM_CLOCK:
		# Obtain from ticks.
		time = (Time.get_ticks_usec() - time_begin) / 1000000.0
		# Compensate.
		time -= time_delay
	elif sync_source == SyncSource.SOUND_CLOCK:
		time = get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency() + (1 / COMPENSATE_HZ) * COMPENSATE_FRAMES

	seconds = time
	if dataIndex < data.size():
		if seconds >= data[dataIndex]:
			playerCollide.emit(dataIndex, seconds)
			dataIndex += 1
	
func _on_changingamedirection_start_game(startIndex : int):
	sync_source = SyncSource.SOUND_CLOCK
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	data = $BlockTiming._load_level_data("time")
	dataIndex = startIndex
	if dataIndex != 0:
		play(data[dataIndex - 1])
	else:
		play()
	isPlaying.emit()

func _on_game_manager_start_game(startIndex : int, songOffset : float):
	sync_source = SyncSource.SOUND_CLOCK
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	data = $BlockTiming._load_level_data("time")
	dataIndex = startIndex
	if dataIndex != 0:
		var songTiming = data[dataIndex - 1] + songOffset
		play(songTiming) 
	else:
		play()
	isPlaying.emit()
	print("Song is playing")
