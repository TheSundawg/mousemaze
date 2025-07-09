extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
