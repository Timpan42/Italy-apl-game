extends Control

var optionsMenu

func _ready():
	optionsMenu = $"Options-Ui"
	optionsMenu.hide()

func _on_button_start_pressed():
	pass

func _on_button_options_pressed():
	optionsMenu.show()

func _on_button_quit_pressed():
	get_tree().quit()

func _on_options_ui_close_options():
	optionsMenu.hide()

func _on_options_ui_close_window():
	optionsMenu.hide()
