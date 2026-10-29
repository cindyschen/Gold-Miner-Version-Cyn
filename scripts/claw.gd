extends Node2D

const swing_angle= 60.0
const swing_speed= 2.0

func _process(_delta: float) -> void:
	rotation = deg_to_rad(swing_angle) * sin(Time.get_ticks_msec() / 1000.0 * swing_speed)
