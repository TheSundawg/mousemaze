extends Node

# Global Signals

signal area_entered(my_area: Area2D, area: Area2D)
signal exit_level(my_area: Area2D, mouse_area:Area2D)
signal pass_timer_time(string: String)
signal pass_timer_stop(stop: bool)
signal can_pulse(pulse: bool)
signal is_dead(dead: bool)
signal pass_score (score: String)
signal pass_levels(this_level: String, next_level: String)
signal lives_left(lives: int)
