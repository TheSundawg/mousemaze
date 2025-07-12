extends Node
var level_time: String
var rem_lives: int
var level_name: String
var time_array: Array
var lives_array: Array
var name_array: Array

signal level_data(time: String, lives: int, level_name: String)
signal print_level(time: Array, lives: Array, names: Array)

func _ready() -> void:
	BgData.level_data.connect(_on_level_data)

func _on_level_data(time,lives,level_title):
	
	time_array.append(time)
	lives_array.append(lives)
	name_array.append(level_title)
	print_level.emit(time_array, lives_array, name_array)
