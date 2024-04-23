extends StaticBody2D

func _animate_down():
	var tween = create_tween()
	for platforms in get_children():
		tween.tween_property(platforms, "position", Vector2(0, 0), 2).set_trans(Tween.TRANS_QUAD)
