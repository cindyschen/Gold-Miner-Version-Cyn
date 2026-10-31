extends Area2D

@export var retract_speed: float = 200.0
@export var points: int = 250

func _ready():
	var random = randi_range(0,2)
	if random == 0:
		retract_speed = 90
	elif random == 1:
		retract_speed = 150
	else:
		retract_speed = 300
	
	points = randi_range(50, 500)
