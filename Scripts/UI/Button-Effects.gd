extends ColorRect

var defaultColor : Color
var hoverColor : Color = Color(0.188, 0.188, 0.188)

func _ready():
	defaultColor = color

func _on_button_focus_entered():
	color = hoverColor

func _on_button_mouse_entered():
	color = hoverColor

func _on_button_focus_exited():
	color = defaultColor

func _on_button_mouse_exited():
	color = defaultColor
