extends Node2D

var can_pulse = true


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "pulse":
		can_pulse = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pulse":
		can_pulse = true

func _process(delta: float) -> void:
	GlobalEvents.can_pulse.emit(can_pulse)
