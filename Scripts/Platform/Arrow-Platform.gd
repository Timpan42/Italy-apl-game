extends Area2D

@export_enum("up", "down", "left", "right") var sendingPlayerDirection : String
@export var turnOfGravity : bool = false

func _get_sending_player_direction():
	return sendingPlayerDirection

func _get_turn_of_gravity():
	return turnOfGravity

func _on_body_entered(player):
	player._collide_with_direction_block(sendingPlayerDirection)

func _on_body_exited(player):
	player._exited_direction_block()

func _on_ok_collision_body_entered(player):
	player._on_ok_collider()

func _on_great_collision_body_entered(player):
	player._on_great_collider()

func _on_perfect_collision_body_entered(player):
	player._on_perfect_collider()

func _on_send_player_body_entered(player):
	player._send_direction(turnOfGravity)

