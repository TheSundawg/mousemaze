extends Control

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	BgData.volume.emit()


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
