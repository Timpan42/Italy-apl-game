extends Node

var masterVolume : float = 1
var musicVolume : float = 0.7

var save_dir_path = "user://"
var save_file_path = save_dir_path + "save_data.dat"


func _ready():
	_load_from_file()
	

func _save_to_file():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)  
	var data = _send_player_data()
	print(data)
	file.store_var(data)

func _send_player_data():
	var player_options_sound = {
		"MASTER" : masterVolume,
		"MUSIC_VOLUME" : musicVolume
	}
	return player_options_sound

func _load_from_file():
	var file = FileAccess.open(save_file_path, FileAccess.READ)
	if file == null:
		file = FileAccess.open(save_file_path, FileAccess.WRITE)
		var data = _send_player_data()
		print(data)
		file.store_var(data)
	elif FileAccess.file_exists(save_file_path):
		var load_data = file.get_var()
		masterVolume = load_data.MASTER
		musicVolume = load_data.MUSIC_VOLUME
