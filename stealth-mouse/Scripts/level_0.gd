extends Node2D

# Global Events
# Global Variables
var timeout: bool
var wall_anim: AnimationPlayer
var wall_array: Array
var wall_instance: Area2D
# Input Related Functions
func _quit_game():
	if Input.is_action_pressed("quit"):
		get_tree().quit()

func _detection_sphere():
	var mouse_pos = get_global_mouse_position()
	
	if Input.is_action_just_pressed("pulse"):
		$detection.global_position.x = mouse_pos.x
		$detection.global_position.y = mouse_pos.y
		$detection/AnimationPlayer.play("pulse")

func _sprite_cursor():
	var cursor = $cursor
	var mouse_position = get_global_mouse_position()

	if cursor.position != mouse_position:
		cursor.position.x = mouse_position.x
		cursor.position.y = mouse_position.y

func _on_area_entered(area, mouse):
	if area.get_parent() is Node2D and area.get_parent().has_node("AnimationPlayer") and !mouse.get_parent().has_node("DeathBox"):
		var area_instance = area.get_parent()
		area_instance.get_node("AnimationPlayer").play("Flash")
	else:
		get_tree().quit()

func _on_exit_level(exit_area, mouse_area):
	if exit_area.get_parent() is Node2D and mouse_area.get_parent().has_node("DeathBox"):
		get_tree().change_scene_to_file("res://Levels/Level1.tscn")

func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	
	
	GlobalEvents.area_entered.connect(_on_area_entered)
	GlobalEvents.exit_level.connect(_on_exit_level)
	
func _process(float):
	_quit_game()
	_sprite_cursor()
	_detection_sphere()
