extends Control

@onready var textLabel = $RichTextLabel

func AddText(text : String):
	textLabel.append_text(text)

func ClearText():
	textLabel.clear()
