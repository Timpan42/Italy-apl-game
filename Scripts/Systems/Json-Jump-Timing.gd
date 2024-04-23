extends Node

@export var fileName : String

func _load_level_data(dataReturn : String):
	var file = FileAccess.open(fileName, FileAccess.READ)
	if file == null:
		print("no file")
		return

	var data : Array
	var content = file.get_as_text()
	content = JSON.parse_string(content)
	data = _get_data(data, content, dataReturn)
	return data

func _get_data(data : Array, content, fromFile : String):
	for index in range(content.size()):
		data.append(content[index]["platform"][fromFile]) 
	return data 
