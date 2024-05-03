extends Control

@export var masterSlider : OptionSlider
@export var musicSlider : OptionSlider
 
signal closeOptions

func _ready():
	masterSlider._on_start(AudioManager.masterVolume)
	musicSlider._on_start(AudioManager.musicVolume)

func _save_audio_seting():
	AudioManager.masterVolume = masterSlider.value
	AudioManager.musicVolume = musicSlider.value
	AudioManager._save_to_file()

func _on_back_pressed():
	_save_audio_seting()
	closeOptions.emit()

func _on_save_pressed():
	_save_audio_seting()
