extends Node2D

var dead = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dead":
		dead = true
		GlobalEvents.is_dead.emit(dead)
