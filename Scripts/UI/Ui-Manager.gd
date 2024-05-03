extends Control

@export var pauseUi : Control
@export var optionUi : Control

func _ready():
	#pauseUi.hide()
	optionUi.hide()

func _on_pause_ui_open_options():
	pauseUi.hide()
	optionUi.show()

func _on_options_ui_close_options():
	pauseUi.show()
	optionUi.hide()
