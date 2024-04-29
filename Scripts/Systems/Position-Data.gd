extends Node

@export var fileName : String 
@export var velocity : float 
var id = 1
var data = []
var timeData
var time 
var playing
var distanceFromLastBlock = 0
var lastBlock = 0

signal startProgram(time)

func _ready():
	startProgram.emit("time")

func _on_block_timing_data_ready(data):
	timeData = data
	_calculate_position()

func _calculate_position():
	for index in range(timeData.size()):
		time = timeData[index]
		var distance = velocity * time
		save_position(distance, time)
	_save_file()

func save_position(distance : float, time):
	distanceFromLastBlock = distance - lastBlock
	var distanceData : Dictionary = {
		"id" : id,
		"distance" : distance,
		"distanceFromLastBlock" : distanceFromLastBlock,
		"time" : time
	}
	lastBlock = distance
	id += 1
	data.append(distanceData)

func _save_file():
	var filePath = "res://LevelInfo/Platform-Distance-" + fileName + ".json"
	var file = FileAccess.open(filePath, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, "\t"))
	file.close()
	print("program done")
	await print("exceeding program")
	get_tree().quit()
	


