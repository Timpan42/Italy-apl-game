extends Node2D

const moveSpeed = 400


func _on_player_player_bounce():
	var tween = get_tree().create_tween()
	var platformMovePosition = position.y
	platformMovePosition += moveSpeed
	tween.tween_property(self, "position", Vector2(position.x, platformMovePosition), 1.5).set_trans(Tween.TRANS_QUAD)

