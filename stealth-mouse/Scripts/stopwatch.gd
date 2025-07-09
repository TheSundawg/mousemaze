extends Node2D

var stopped = false
var time = 0.0

func _ready():
	GlobalEvents.pass_timer_stop.connect(_on_pass_timer_stop)

func _on_pass_timer_stop(stop):
	stopped = stop

func _on_timer_timeout() -> void:
	_update_label()
	var label_up = _time_to_string()
	GlobalEvents.pass_timer_time.emit(label_up)

func _update_label():
	$Label.text = _time_to_string()

func _process(delta: float):
	if stopped:
		return
	else:
		time += delta
	
func _reset():
	time = 0.0

func _time_to_string() -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var min = time / 60
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [min, sec, msec]
	return actual_string
