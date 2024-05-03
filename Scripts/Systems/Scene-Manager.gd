extends Node

var current_Scene = null

func _ready():
	var root = get_tree().root
	current_Scene = root.get_child(root.get_child_count() - 1)

func _switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)

func _deferred_switch_scene(res_path):
	current_Scene.free()
	var scene = load(res_path)
	current_Scene = scene.instantiate()
	get_tree().root.add_child(current_Scene)
	get_tree().current_scene = current_Scene 
