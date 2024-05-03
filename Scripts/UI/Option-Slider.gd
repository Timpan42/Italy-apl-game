class_name OptionSlider
extends HSlider

@export var bus_name : String
var bus_index : int 

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)

func _on_start(loaded_value : float):
	AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(loaded_value)
	)
	
	value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)

@warning_ignore("shadowed_variable_base_class")
func _on_value_changed(value : float):
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)

func _on_decrease_pressed():
	value -= 0.1


func _on_increase_pressed():
	value += 0.1
