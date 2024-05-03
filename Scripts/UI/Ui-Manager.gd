extends Control

@export var pauseUi : Control
@export var optionUi : Control


func _on_pause_ui_open_options():
	pauseUi.visible = false
	optionUi.visible = true
