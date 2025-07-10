extends Control

var updated_score: String
var next_level: String
var this_level: String


func _ready() -> void:
	GlobalEvents.pass_score.connect(_on_pass_score)
	GlobalEvents.pass_levels.connect(_on_pass_levels)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
func _on_pass_score(string):
	$TimeScore.text = string

func _on_pass_levels(this, next):
	this_level = this
	next_level = next

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file(next_level)

func _on_try_again_pressed() -> void:
	get_tree().change_scene_to_file(this_level)


func _on_quit_pressed() -> void:
	get_tree().quit()
