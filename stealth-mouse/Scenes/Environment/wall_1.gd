extends Node2D



func _on_area_2d_area_entered(area: Area2D) -> void:
	var my_area = $Area2D
	GlobalEvents.area_entered.emit(my_area, area)
