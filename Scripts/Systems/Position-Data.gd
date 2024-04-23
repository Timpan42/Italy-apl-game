extends Node

@export var fileName : String 
var id = 1
var data = []

func _update_data(pos : Vector2):
	var posData : Dictionary = {
		"id" : id,
		"position" : pos,
	}
	id += 1
	data.append(posData)

func _save_position_data():
	var filePath = "res://LevelInfo/Platform-Position" + fileName + ".json"
	var file = FileAccess.open(filePath, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, "\t"))
	file.close()
