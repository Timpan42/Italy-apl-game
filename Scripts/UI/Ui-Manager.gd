extends Control

@export var pauseUi : Control
@export var optionUi : Control

var menu_path = "res://Scene/Main-Menu.tscn"


func _ready():
	pauseUi.hide()
	optionUi.hide()

func _close_window():
	pauseUi.hide()
	optionUi.hide()

func _close_game():
	get_tree().quit()

func _close_option_open_pause():
	pauseUi.show()
	optionUi.hide()

func _close_pause_open_option():
	pauseUi.hide()
	optionUi.show()

func _on_pause_ui_close_window():
	_close_window()

func _on_pause_ui_open_options():
	_close_pause_open_option()

func _on_pause_ui_restart_level():
	SceneManager._reload_scene()

func _on_pause_ui_open_main_menu():
	SceneManager._switch_scene(menu_path)

func _on_pause_ui_close_game():
	_close_game()

func _on_options_ui_close_window():
	_close_window()

func _on_options_ui_close_options():
	_close_option_open_pause()
