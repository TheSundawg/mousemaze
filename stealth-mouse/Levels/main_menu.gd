extends Control

var file: FileAccess
const save_location = "user://SaveFile.tres"
var save_file: SaveDataResource
var names: Array
var time: Array
var lives: Array

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	BgData.volume.emit()
	_load()
	

func _load():
	if FileAccess.file_exists(save_location):
		save_file = ResourceLoader.load(save_location).duplicate(true)
		names = save_file.name_array
		time = save_file.time_array
		lives = save_file.lives_array
		print(names + time + lives)
		
		for x in time:
			$Score/Time.text += "\n" + x
		for x in lives:
			$Score/Lives.text += "\n" +  str(x)
		for x in names:
			$Score/Level.text += "\n" +  x

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Level0.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_levels_pressed() -> void:
	pass # Replace with function body.

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Options.tscn")

func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	else:
		get_window().mode = Window.MODE_WINDOWED
