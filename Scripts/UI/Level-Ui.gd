extends Control

@export var levelName : String
@export_file var toLevel 
var levelHolder

func _ready():
	$Label.text = "Level: " + levelName
	levelHolder = get_parent()

func _emit_level():
	if toLevel != null:
		return toLevel

func _on_button_pressed():
	if toLevel != null:
		levelHolder._send_level(toLevel)

func _on_button_focus_entered():
	pass

func _on_button_focus_exited():
	pass
