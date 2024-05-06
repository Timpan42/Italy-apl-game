extends Control

var optionsMenu
var mainScreen
var levelScreen

func _ready():
	mainScreen = $Main
	levelScreen = $LevelSelect
	optionsMenu = $"Options-Ui"
	levelScreen.hide()
	optionsMenu.hide()
	mainScreen.show()

func _change_level(level):
	SceneManager._switch_scene(level)

func _on_button_start_pressed():
	mainScreen.hide()
	levelScreen.show()

func _on_button_options_pressed():
	optionsMenu.show()

func _on_button_quit_pressed():
	get_tree().quit()

func _on_options_ui_close_options():
	optionsMenu.hide()

func _on_options_ui_close_window():
	optionsMenu.hide()

func _on_levels_change_level(level):
	_change_level(level)
