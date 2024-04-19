extends Node

var path
var id : int 
var pos : Vector2

var data  = []

func _update_data(inputId, inputPos):
	var inputData : Dictionary = {
	"platform" : {
		"id" : inputId,
		"pos" : inputPos
	}
}
	data.append(inputData)

func _save_to_file(levelName):
	var file
	path = "res://LevelInfo/level" + levelName + ".json"
	file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, "\t"))
	file.close()
	file = null

