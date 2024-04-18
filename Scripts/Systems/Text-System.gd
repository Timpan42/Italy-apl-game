extends Area2D

var textShown : bool = false
@export var sendText : String
var showText
func _ready():
	showText = $ShowText
	showText.ClearText()

func _on_body_entered(_body):
	if !textShown:
		showText.AddText(sendText)
		textShown = true


