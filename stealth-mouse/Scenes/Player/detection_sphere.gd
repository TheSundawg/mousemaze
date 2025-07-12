extends Node2D

var can_pulse = true
var died = false

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "pulse":
		$AnimationPlayer/Pulse.play()
		$AnimationPlayer/Sonar.play()
		can_pulse = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pulse":
		can_pulse = true
	elif anim_name == "dead":
		$AnimationPlayer.play("RESET")
func _process(_delta: float) -> void:
	GlobalEvents.can_pulse.emit(can_pulse)
