extends Button

var menu_path = "res://Levels/Tutorial1.tscn"

func _on_pressed():
	SceneManager._switch_scene(menu_path)
