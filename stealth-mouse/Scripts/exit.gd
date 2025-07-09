extends Node2D





func _on_exit_area_area_entered(area: Area2D) -> void:
	var my_area = $ExitArea
	GlobalEvents.exit_level.emit(my_area, area)
