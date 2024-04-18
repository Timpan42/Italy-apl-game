extends Area2D

@export var Id : int = 0;
signal playerEntered(Id)

func _on_body_entered(_body):
	playerEntered.emit(Id)
