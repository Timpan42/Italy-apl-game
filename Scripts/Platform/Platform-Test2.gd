extends StaticBody2D

@export var pushPlayerForce : float = 1000
@export var changeGravity : float  = 980

func _get_push_player_force():
	return pushPlayerForce

func _get_change_gravity():
	return changeGravity
