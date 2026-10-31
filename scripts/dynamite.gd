extends Area2D

const SPEED = 1000

signal dynamite_hit
var direction: Vector2
var hit = false
var target: Area2D

func _process(delta):
	position+= direction *SPEED *delta
	
func _on_area_entered(area: Area2D) -> void:
	if area == target:
		dynamite_hit.emit()
		hit = true
		area.queue_free()
		queue_free()
