extends Control

@export var levelName : String
@export_file var toLevel 


func _ready():
	$Label.text = "Level: " + levelName

func _emit_level():
	return toLevel

func _on_button_pressed():
	_emit_level()

func _on_button_focus_entered():
	pass

func _on_button_focus_exited():
	pass
