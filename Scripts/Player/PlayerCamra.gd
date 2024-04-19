extends Camera2D

@onready var player = $"../Player"
@export var speed : float

func _physics_process(delta):
	position = lerp(position, player.position, speed * delta)
