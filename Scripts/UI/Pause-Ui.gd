extends Control

signal closeWindow
signal restartLevel
signal openOptions
signal openMainMenu
signal closeGame


func _on_close_window_pressed():
	closeWindow.emit()

func _on_restart_pressed():
	restartLevel.emit()

func _on_main_menu_pressed():
	openMainMenu.emit()

func _on_exit_pressed():
	closeGame.emit()

func _on_options_pressed():
	openOptions.emit()
