extends TextureButton

@export var menuHolder : ColorRect

func _on_pressed():
	menuHolder.visible = false
