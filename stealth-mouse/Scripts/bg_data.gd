extends Node
var level_time: String
var rem_lives: int
var level_name: String
var time_array: Array
var lives_array: Array
var name_array: Array
var array_array: Array
const save_location = "user://SaveFile.tres"
var save_file: SaveDataResource = SaveDataResource.new()

signal level_data(time: String, lives: int, level_name: String)
signal print_level(time: Array, lives: Array, names: Array)
signal volume(toggled: bool)
signal save_game()

func _ready() -> void:
	BgData.level_data.connect(_on_level_data)
	BgData.save_game.connect(_on_save_game)

func _on_level_data(time,lives,level_title):
	
	time_array.append(time)
	lives_array.append(lives)
	name_array.append(level_title)
	print_level.emit(time_array, lives_array, name_array)
	
func _on_save_game():
	save_file.time_array = time_array
	save_file.lives_array = lives_array
	save_file.name_array = name_array
	ResourceSaver.save(save_file, save_location)
