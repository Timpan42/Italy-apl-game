extends Area2D

@export_enum("up", "down", "left", "right") var sendingPlayerDirection : String
@export var turnOfGravity : bool = false

func _on_body_exited(player):
	player._exited_direction_block()

func _on_ok_collision_body_entered(player):
	player._on_ok_collider()

func _on_great_collision_body_entered(player):
	player._on_great_collider()

func _on_perfect_collision_body_entered(player):
	player._on_perfect_collider()

func _on_send_player_body_entered(player):
	player._collide_with_direction_block(sendingPlayerDirection, turnOfGravity)
