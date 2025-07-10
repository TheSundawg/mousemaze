extends Node2D

# Global Events
# Global Variables
var score: String
var exit = false
var pulsible: bool
var wall_anim: AnimationPlayer
var wall_array: Array
var wall_instance: Area2D
var prev_level = "res://Levels/MainMenu.tscn"
var this_level = "res://Levels/Level1.tscn"
var next_level = "res://Levels/Level2.tscn"
var lives_left: int


# Input Related Functions
func _quit_game():
	if Input.is_action_pressed("quit"):
		get_tree().quit()

func _on_can_pulse(boolean):
	pulsible = boolean
	

func _detection_sphere():
	var mouse_pos = get_global_mouse_position()
	
	if Input.is_action_just_pressed("pulse") and pulsible == true:
		$detection.global_position.x = mouse_pos.x
		$detection.global_position.y = mouse_pos.y
		$detection/AnimationPlayer.play("pulse")
	else:
		return

func _sprite_cursor():
	var cursor = $cursor
	var mouse_position = get_global_mouse_position()

	if cursor.position != mouse_position:
		cursor.position.x = mouse_position.x
		cursor.position.y = mouse_position.y

func _on_area_entered(area, mouse):
	var spawn = $spawn_pos.position
	if area.get_parent() is Node2D and exit == false and area.get_parent().has_node("AnimationPlayer") and !mouse.get_parent().has_node("DeathBox"):
		var area_instance = area.get_parent()
		area_instance.get_node("AnimationPlayer").play("Flash")
		$cursor/AnimationPlayer.play("pulse_activated")
		$Exit/AnimationPlayer.play("pulse")
	elif exit == true:
		return
	elif lives_left == -1:
		get_tree().change_scene_to_file("res://Levels/MainMenu.tscn")
	else:
		lives_left = lives_left - 1
		get_viewport().warp_mouse(spawn)
		
	#if lives_left < 3 and lives_left > 1:
	#	$"LifeBox/Heart 3".visible = false
	#elif $"LifeBox/Heart 3".visible == false and lives_left < 2 and lives_left > 0:
	#	$"LifeBox/Heart 2".visible = false
	
	



func _on_pass_timer_time(stringy):
	$Score/TimeScore.text = stringy

func _on_exit_level(area, mouse):
	if area.get_parent() is Node2D and mouse.get_parent().has_node("DeathBox"):
		GlobalEvents.pass_timer_stop.emit(true)
		exit = true
		$Score.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		GlobalEvents.pass_levels.emit(this_level, next_level)

func _ready():
	var spawn = $spawn_pos.position
	lives_left = 3
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	get_viewport().warp_mouse(spawn)
	
	GlobalEvents.area_entered.connect(_on_area_entered)
	GlobalEvents.pass_timer_time.connect(_on_pass_timer_time)
	GlobalEvents.exit_level.connect(_on_exit_level)
	GlobalEvents.can_pulse.connect(_on_can_pulse)
	
func _process(float):
	_quit_game()
	_sprite_cursor()
	_detection_sphere()
	
