extends Node2D

# Global Events
# Global Variables
var score: String
var exit = false
var pulsible: bool
var wall_anim: AnimationPlayer
var wall_array: Array
var wall_instance: Area2D
var prev_level = "res://Levels/Level2.tscn"
var this_level = "res://Levels/Level3.tscn"
var next_level = "res://Levels/Level4.tscn"
var lives_left: int

var music: bool

func _ready():
	var spawn = $spawn_pos.position
	lives_left = 0
	
	$Music.play()
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	get_viewport().warp_mouse(spawn)
	
	GlobalEvents.area_entered.connect(_on_area_entered)
	GlobalEvents.pass_timer_time.connect(_on_pass_timer_time)
	GlobalEvents.exit_level.connect(_on_exit_level)
	GlobalEvents.can_pulse.connect(_on_can_pulse)
	BgData.print_level.connect(_on_print_level)
	BgData.volume.connect(_on_volume)

func _on_volume(toggled):
	music = toggled
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
	else:
		lives_left += 1
		print(lives_left)
		$cursor/AnimationPlayer.play("dead")
		get_viewport().warp_mouse(spawn)
		$Dead.play()

func _on_pass_timer_time(stringy):
	$Score/TimeScore.text = stringy

func _on_exit_level(area, mouse):
	if area.get_parent() is Node2D and mouse.get_parent().has_node("DeathBox"):
		GlobalEvents.pass_timer_stop.emit(true)
		exit = true
		$Score.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		GlobalEvents.pass_levels.emit(this_level, next_level)
		BgData.level_data.emit($Score/TimeScore.text,lives_left,"Level 1")
		$"cursor/DeathBox".process_mode = Node.PROCESS_MODE_DISABLED
		$Music.stop()
		$ExitMusic.play()

func _on_print_level(time, lives, names):
	for x in time:
		$Score/Time.text += "\n" + x
	for x in lives:
		$Score/Lives.text += "\n" +  str(x)
	for x in names:
		$Score/Level.text += "\n" +  x
	

func _process(_float):
	_quit_game()
	_sprite_cursor()
	_detection_sphere()
	


func _on_music_finished() -> void:
	$Music.play()


func _on_exit_music_finished() -> void:
	$ExitMusic.play()
