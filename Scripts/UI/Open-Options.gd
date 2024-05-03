extends Button

signal toOptionMenu

func _on_pressed():
	toOptionMenu.emit()
